unit uelf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  Type

    { TElf }

    TElf = class
    strict private
      name: string;
      maxHP: integer;
      hp: integer;
      posX: integer;
      posY: integer;
      speed: integer;
      kindofnpc : string;       //important cause one elf wont be an enemy but and npc to talk to in room 2
      velocity: array [0..1] of integer;
    public
      constructor create(nm: string; maxHealth: integer; spd: integer; konpc : string);
      procedure changeHP(value: integer);
      procedure move(x: integer; y: integer);
      procedure setPos(x: integer; y: integer);
      function getHP(): integer;
      function getPosX(): integer;
      function getPosY(): integer;
      function getSpeed(): integer;
      function getKindofNpc() : string;

    end;

implementation

{ TElf }


constructor TElf.create(nm: string; maxHealth: integer; spd: integer;konpc : string);
begin
  name := nm;
  maxHP := maxHealth;
  hp := maxHealth;
  speed := spd;
  konpc := kindofnpc;
end;
procedure TElf.changeHP(value: integer);
begin
  hp := hp + value;
  if hp < 0 then
  begin
    hp := 0;
    // some sort of dying procedure
  end;
end;

// Entity in eine bestimmte Richtung bewegen (relativ zur momentanen Position)
procedure TElf.move(x: integer; y: integer);
begin
  posX := posX + x;
  posY := posY + y;
end;

// Absolute Position der Entity setzen
procedure TElf.setPos(x: integer; y: integer);
begin
  posX := x;
  posY := y;
end;

function TElf.getHP(): integer;
begin
  Result := hp;
end;

function TElf.getPosX(): integer;
begin
  Result := posX;
end;

function TElf.getPosY(): integer;
begin
  Result := posY;
end;
function TElf.getSpeed(): integer;
begin
  Result := speed;
end;

function TElf.getKindofNpc(): string;
begin
  Result := kindofnpc;
end;

end.

