unit uentitydisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_Image, UEntity;

type
  playerMvStatus = (MV_STANDING = 0, MV_WALKING1, MV_WALKING2,
                   MV_JUMPING1, MV_JUMPING2, MV_ATTACK1, MV_ATTACK2);

  { TEntityDisplay }

  TEntityDisplay = class
    protected
      renderer: PSDL_Renderer;
      txtr: PSDL_Texture;
      rect: TSDL_Rect;
      entity: TEntity;
      flip: boolean;
      width: integer;
      height: integer;
      movementStatus : playerMvStatus;
      movementFrames: array [0..6] of PSDL_Texture;
      moveAnimationCounter: integer;
    public
      constructor create(rendr: PSDL_Renderer; w: integer; h: integer; ent: TEntity);
      procedure draw();
      procedure loadTextures(); virtual;
      procedure selectTexture(); virtual;
      procedure setFlip(value: boolean);
      procedure setMovementStatus(status : playerMvStatus);
      function getMovementStatus(): playerMvStatus;
      function getFlip(): boolean;
      function getWidth(): integer;
      function getHeight(): integer;
      procedure setMoveAnimationCounter(value: integer);
      function getMoveAnimationCounter(): integer;
      destructor destroy(); override;
  end;

implementation

constructor TEntityDisplay.create(rendr: PSDL_Renderer; w: integer; h: integer; ent: TEntity);
begin
  renderer := rendr;
  rect.w := w;
  rect.h := h;
  width := w;
  height := h;
  entity := ent;
  flip := true;
  moveAnimationCounter := 0;
  movementStatus := MV_STANDING;
end;

procedure TEntityDisplay.draw();
begin
  rect.x := entity.getPosX;
  rect.y := entity.getPosY;
  selectTexture();
  if flip then
  begin
    SDL_RenderCopyEx(renderer, txtr, nil, @rect, 0, nil, SDL_FLIP_HORIZONTAL);
  end
  else
  begin
    SDL_RenderCopy(renderer, txtr, nil, @rect);
  end;
end;

procedure TEntityDisplay.loadTextures();
begin
  // To be implemented by subclasses, basically abstract
end;

procedure TEntityDisplay.selectTexture();
begin
  txtr := movementFrames[integer(movementStatus)];
end;

procedure TEntityDisplay.setFlip(value: boolean);
begin
  flip := value;
end;

procedure TEntityDisplay.setMovementStatus(status: playerMvStatus);
begin
  MovementStatus := status;
end;

function TEntityDisplay.getMovementStatus(): playerMvStatus;
begin
  Result := movementStatus;
end;

function TEntityDisplay.getFlip(): boolean;
begin
  Result := flip;
end;

function TEntityDisplay.getWidth(): integer;
begin
  Result := width;
end;

function TEntityDisplay.getHeight(): integer;
begin
  Result := height;
end;

procedure TEntityDisplay.setMoveAnimationCounter(value: integer);
begin
  moveAnimationCounter := value;
end;

function TEntityDisplay.getMoveAnimationCounter(): integer;
begin
  Result := moveAnimationCounter;
end;

destructor TEntityDisplay.destroy();
var
  i: integer;
begin
  for i:=Low(movementFrames) to High(MovementFrames) do
  begin
    SDL_DestroyTexture(movementFrames[i]);
  end;
end;

end.

