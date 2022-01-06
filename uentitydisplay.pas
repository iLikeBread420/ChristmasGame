unit uentitydisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_Image, UEntity;

type

  { TEntityDisplay }

  TEntityDisplay = class
    strict private
      mainTexture: PSDL_Texture;
      renderer: PSDL_Renderer;
      rect: TSDL_Rect;
      entity: TEntity;
      flip: boolean;
      width: integer;
      height: integer;
      MovementStatus : string;
    public
      constructor create(rendr: PSDL_Renderer; img: string; w: integer; h: integer; ent: TEntity);
      procedure draw();
      procedure setFlip(value: boolean);
      procedure setMovementStatus(status : string);
      function getFlip(): boolean;
      function getWidth(): integer;
      function getHeight(): integer;
      destructor destroy(); override;
  end;

implementation

constructor TEntityDisplay.create(rendr: PSDL_Renderer; img: string; w: integer; h: integer; ent: TEntity);
begin
  renderer := rendr;
  mainTexture := IMG_LoadTexture(renderer, PChar(img));
  rect.w := w;
  rect.h := h;
  width := w;
  height := h;
  entity := ent;
  flip := true;
end;

procedure TEntityDisplay.draw();
begin
  rect.x := entity.getPosX;
  rect.y := entity.getPosY;
  case MovementStatus of
    'd_standing': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Default.standpng.png');
    'd_walking1': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Walking.1.png');
    'd_walking2': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Walking.2.png');
    'd_jumpting1': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Jumping.1.png');
    'd_jumping2': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Jumping.2.png');
    'attack1': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Attack.1.png');
    'attack2': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Attack.2.png');
    'w_standing': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Standpng.Holdin.Weapon.png');
    'w_walking1': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Walking.1.HoldingWeapon.png');
    'w_walking2': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Walking.2.Holding.Weapon.png');
    'w_jumpting1': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Jumping.2.Holding.Weapon.png');
    'w_jumping2': mainTexture := IMG_LoadTexture(renderer, 'assets/MC.Jumping.2.Holding.Weapon.png');
  end;
  if flip then
  begin
    SDL_RenderCopyEx(renderer, mainTexture, nil, @rect, 0, nil, SDL_FLIP_HORIZONTAL);
  end
  else
  begin
    SDL_RenderCopy(renderer, mainTexture, nil, @rect);
  end;
end;
procedure TEntityDisplay.setFlip(value: boolean);
begin
  flip := value;
end;

procedure TEntityDisplay.setMovementStatus(status: string);
begin
  MovementStatus := status;
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

destructor TEntityDisplay.destroy();
begin
  SDL_DestroyTexture(mainTexture);
end;

end.

