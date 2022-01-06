unit uplayerdisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_Image, UEntityDisplay, UEntity;

type
  TPlayerDisplay = class(TEntityDisplay)
    strict private
      weaponMovementFrames: array[0..6] of PSDL_Texture;
      isWeaponized: boolean;
    public
      constructor create(rendr: PSDL_Renderer; w: integer; h: integer; ent: TEntity);
      procedure loadTextures(); override;
      procedure selectTexture(); override;
      procedure setIsWeaponized(value: boolean);
      function getIsWeaponized(): boolean;
      destructor destroy(); override;
  end;

implementation

constructor TPlayerDisplay.create(rendr: PSDL_Renderer; w: integer; h: integer; ent: TEntity);
begin
  inherited create(rendr, w, h, ent);
  isWeaponized := false;
  loadTextures();
end;

procedure TPlayerDisplay.loadTextures();
begin
  movementFrames[0] := IMG_LoadTexture(renderer, 'assets/MC.Default.standpng.png');
  movementFrames[1] := IMG_LoadTexture(renderer, 'assets/MC.Walking.1.png');
  movementFrames[2] := IMG_LoadTexture(renderer, 'assets/MC.Walking.2.png');
  movementFrames[3] := IMG_LoadTexture(renderer, 'assets/MC.Jumping.1.png');
  movementFrames[4] := IMG_LoadTexture(renderer, 'assets/MC.Jumping.2.png');
  movementFrames[5] := IMG_LoadTexture(renderer, 'assets/MC.Attack.1.png');
  movementFrames[6] := IMG_LoadTexture(renderer, 'assets/MC.Attack.2.png');
  weaponMovementFrames[0] := IMG_LoadTexture(renderer, 'assets/MC.Standpng.Holdin.Weapon.png');
  weaponMovementFrames[1] := IMG_LoadTexture(renderer, 'assets/MC.Walking.1.HoldingWeapon.png');
  weaponMovementFrames[2] := IMG_LoadTexture(renderer, 'assets/MC.Walking.2.Holding.Weapon.png');
  weaponMovementFrames[3] := IMG_LoadTexture(renderer, 'assets/MC.Jumping.2.Holding.Weapon.png');
  weaponMovementFrames[4] := IMG_LoadTexture(renderer, 'assets/MC.Jumping.2.Holding.Weapon.png');
  weaponMovementFrames[5] := IMG_LoadTexture(renderer, 'assets/MC.Attack.1.png');
  weaponMovementFrames[6] := IMG_LoadTexture(renderer, 'assets/MC.Attack.2.png');
end;

procedure TPlayerDisplay.selectTexture();
begin
  if isWeaponized then
  begin
    txtr := weaponMovementFrames[integer(movementStatus)];
  end
  else
  begin
    txtr := movementFrames[integer(movementStatus)];
  end;
end;

procedure TPlayerDisplay.setIsWeaponized(value: boolean);
begin
  isWeaponized := value;
end;

function TPlayerDisplay.getIsWeaponized(): boolean;
begin
  Result := isWeaponized;
end;

destructor TPlayerDisplay.destroy();
var
  i: integer;
begin
  for i:=Low(movementFrames) to High(MovementFrames) do
  begin
    SDL_DestroyTexture(movementFrames[i]);
  end;
  for i:=Low(weaponMovementFrames) to High(weaponMovementFrames) do
  begin
    SDL_DestroyTexture(weaponMovementFrames[i]);
  end;
end;

end.

