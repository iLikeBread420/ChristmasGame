unit ugamedisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, SDL2, UEntity, UEntityDisplay, UPlayerDisplay, URoom, URoomDisplay;

const
  WIDTH: integer = 1920;
  HEIGHT: integer = 1200;

type
  // Diese Klasse setzt praktisch alles zusammen
  TGameDisplay = class
    strict private
      has_error: integer;
      window: PSDL_Window;
      renderer: PSDL_Renderer;
      event: PSDL_Event;
      player: TEntity;
      playerDisplay: TEntityDisplay;
      currentRoom: TRoom;
      currentRoomDisplay: TRoomDisplay;
      roomArray: array [0..6] of TRoom;
      procedure KeepInBounds();
    public
      constructor create();
      procedure show();
      destructor destroy(); override;
  end;

implementation

constructor TGameDisplay.create();
begin
  has_error := SDL_Init(SDL_INIT_VIDEO OR SDL_INIT_TIMER OR SDL_INIT_EVENTS OR SDL_INIT_AUDIO);
  has_error := SDL_CreateWindowAndRenderer(WIDTH, HEIGHT, SDL_WINDOW_FULLSCREEN, @window, @renderer);

  // Tue so, als waere das Fenster immer 1280x800 Pixel gross.
  has_error := SDL_RenderSetLogicalSize(renderer, 1920, 1200);

  new(event);

  player := TEntity.create('Player', 100, 4);
  playerDisplay := TPlayerDisplay.create(renderer, 250, 220, player);
  player.setPos(25, 1100);

  currentRoom := TRoom.create(RM_INSIDE1, 1);
  // Add entities to the room here.
  currentRoomDisplay := TRoomDisplay.create(renderer, currentRoom, WIDTH, HEIGHT);
end;

procedure TGameDisplay.show();
var
  running: boolean;
  loopStart, loopEnd, velocityStepEnd: integer;
  elapsedMilli: double;
  dt: double;
  gravity: integer;
  d_pressed, a_pressed: boolean;
begin
  if has_error <> 0 then halt;

  gravity := -30000000;
  a_pressed := false; d_pressed := false;

  running := true;
  while running do
  begin
    loopStart := SDL_GetPerformanceCounter();
    velocityStepEnd := SDL_GetPerformanceCounter();
    dt := (velocityStepEnd - loopStart) / SDL_GetPerformanceFrequency() * 1000;

    // Event Loop
    while SDL_PollEvent(event) = 1 do
    begin
      // ^ ist uebrigens in Pascal der Pointer Dereference Operator
      if event^.type_ = SDL_KEYDOWN then
      begin
        // Welche Taste wurde gedrueckt; jeweils verschiedene Dinge tun
        case (event^.key.keysym.sym) of
        SDLK_d : d_pressed := true;
        SDLK_a : a_pressed := true;
        SDLK_SPACE:
        begin
          // Zahl etwas hoeher, weil es so intuitiver ist.
          if player.getPosY >= 1180 - playerDisplay.getHeight() then
          begin
            player.setVelocityY(160000);
            playerDisplay.setMovementStatus(MV_JUMPING2);
          end;
        end;
        //SDLK_s : player.setMovementTowards(DIR_BOTTOM, 1);
        SDLK_ESCAPE : running := false;
      end;
      end
      else if event^.type_ = SDL_KEYUP then
      begin
        case (event^.key.keysym.sym) of
        SDLK_d: d_pressed := false;
        SDLK_a: a_pressed := false;
        //SDLK_w: player.setMovementTowards(DIR_TOP, 0);
        //SDLK_s: player.setMovementTowards(DIR_BOTTOM, 0);
        end;
      end;
    end;

    // Move in Y-Direction for jumping
    player.move(0, -1 * Floor(player.getVelocityY * dt));
    player.setVelocityY(player.getVelocityY + Floor(gravity * dt));

    // Herausfinden, welche Kombinationen von a und d gepresst sind, fuer Bewegung in Richtung x.
    if d_pressed then
    begin
      player.setVelocityX(1);
      playerDisplay.setFlip(true);
    end;
    if a_pressed then
    begin
      playerDisplay.setFlip(false);
      player.setVelocityX(-1);
    end;
    if (d_pressed and a_pressed) or (not(d_pressed) and not(a_pressed)) then
    begin
      player.setVelocityX(0);
    end;

    // Wenn Spieler auf dem Boden steht, a priori movementStatus auf MV_STANDING setzen,
    // um Spring-Animation zu beenden.
    if player.getPosY >= HEIGHT - playerDisplay.getHeight() then
    begin
      // Lauf-Animation fuer den Spieler
      if player.getVelocityX <> 0 then
      begin
        playerDisplay.setMoveAnimationCounter(playerDisplay.getMoveAnimationCounter + 1);
        //playerDisplay.setMovementStatus(MV_WALKING1);
        if playerDisplay.getMoveAnimationCounter > 15 then
        begin
          playerDisplay.setMoveAnimationCounter(0);
          case playerDisplay.getMovementStatus of
          MV_WALKING1: playerDisplay.setMovementStatus(MV_WALKING2);
          MV_WALKING2, MV_STANDING, MV_JUMPING2: playerDisplay.setMovementStatus(MV_WALKING1);
          end;
        end;
      end
      else
      begin
        playerDisplay.setMovementStatus(MV_STANDING);
      end;
    end;
    //walking in another room->create new troom and troomdisplay
    if player.getPosX() >= WIDTH - playerDisplay.getWidth() then
      begin
        case currentRoom.getRoomnumber of
          1: currentRoom := TRoom.create(RM_INSIDE2, 2);
          2: currentRoom := TRoom.create(RM_OUTSIDE, 3);
          3: currentRoom := TRoom.create(RM_OUTSIDE, 4);
          4: currentRoom := TRoom.create(RM_OUTSIDE, 5);
          5: currentRoom := TRoom.create(RM_OUTSIDE, 6);
        end;
        currentRoomDisplay := TRoomDisplay.create(renderer, currentRoom, WIDTH, HEIGHT);
        currentRoom.addEntity(player);
        player.setPos(100, 1100);
      end;

    if player.getPosX() <= 0 then             //render previours room
      begin
        case currentRoom.getRoomnumber of
          2: currentRoom := TRoom.create(RM_OUTSIDE, 1);
          3: currentRoom := TRoom.create(RM_OUTSIDE, 2);
          4: currentRoom := TRoom.create(RM_OUTSIDE, 3);
          5: currentRoom := TRoom.create(RM_OUTSIDE, 4);
        end;
        currentRoomDisplay := TRoomDisplay.create(renderer, currentRoom, WIDTH, HEIGHT);
        currentRoom.addEntity(player);
        player.setPos(1900, 1100);
      end;

    KeepInBounds();

    // Bewegung in X-Richtung
    player.move(player.getVelocityX * player.getSpeed, 0);

    // Rendering
    // Sollte spaeter wahrscheinlich durch einen Loop ersetzt werden.
    currentRoomDisplay.draw();
    playerDisplay.draw();
    // Beschriebene Szene rendern
    SDL_RenderPresent(renderer);
    // Vergangene Zeit seit Beginn des Programms wird zu Anfang und Ende des
    // Loops bestimmt. Die Differenz ist die Zeit, die der Loop benötigt hat.
    // Die Framerate wird mit Delay() auf 60fps (16.666s) gecapped.
    loopEnd := SDL_GetPerformanceCounter();
    // GetPerformanceCounter gibt Zeit in unbekannter Einheit zurueck; daher
    // wird auf Sekunde gebracht mit Teilen durch SDL_GetPerformanceFrequency()
    // und dann auf Millisekunden zurueckkonvertiert durch * 1000
    elapsedMilli := (loopEnd - loopStart) / SDL_GetPerformanceFrequency() * 1000.0;
    SDL_Delay(Floor(16.6666 - elapsedMilli));
    writeln('Elapsed: ' + IntToStr(Floor(16.6666 - elapsedMilli)));
  end;
end;

procedure TGameDisplay.KeepInBounds();
begin
     if (player.getPosX >= WIDTH - playerDisplay.getWidth()) and (currentRoom.getRoomNumber = 6) then
       begin
          player.setPos(WIDTH - playerDisplay.getWidth(), player.getPosY);
          player.setVelocityX(-1 * player.getVelocityX);
    end;
  if (player.getPosX <= 0) and (currentRoom.getRoomnumber <> 1) then
  begin
    player.setPos(0, player.getPosY);
    player.setVelocityX(-1 * player.getVelocityX);
  end;
  if player.getPosY <= 0 then
  begin
    player.setPos(player.getPosX, 0);
    player.setVelocityY(-1 * player.getVelocityY);
  end
  else if player.getPosY >= HEIGHT - playerDisplay.getHeight() then
  begin
    player.setPos(player.getPosX, HEIGHT - playerDisplay.getHeight());
    player.setVelocityY(0);
  end;
end;

destructor TGameDisplay.destroy();
begin
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit();
  inherited;
end;

end.

