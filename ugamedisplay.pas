unit ugamedisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, SDL2, UEntity, UEntityDisplay, URoom, URoomDisplay;

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
  playerDisplay := TEntityDisplay.create(renderer, 'assets/MC.Default.standpng.png', 180, 150, player);
  player.setPos(100, 100);

  currentRoom := TRoom.create(RM_INSIDE);
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
          if player.getPosY >= 1200 - playerDisplay.getHeight() then
          begin
            player.setVelocityY(160000);
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
    end;
    if a_pressed then
    begin
      playerDisplay.setFlip(false);
      player.setVelocityX(-1);
    end;
    if (d_pressed and a_pressed) or (not(d_pressed) and not(a_pressed)) then
    begin
      playerDisplay.setFlip(true);
      player.setVelocityX(0);
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
  if player.getPosX >= WIDTH - playerDisplay.getWidth() then
  begin
    player.setPos(WIDTH - playerDisplay.getWidth(), player.getPosY);
    player.setVelocityX(-1 * player.getVelocityX);
  end
  else if player.getPosX <= 0 then
  begin
    player.setPos(0, player.getPosY);
    player.setVelocityX(-1 * player.getVelocityX);
  end;
  if player.getPosY <= 0 then
  begin
    player.setPos(player.getPosX, 0);
    player.setVelocityY(-1 * player.getVelocityY);
  end
  else if player.getPosY >= 1200 - playerDisplay.getHeight() then
  begin
    player.setPos(player.getPosX, 1200 - playerDisplay.getHeight());
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

