unit uboss;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TBoss = class
    strict private
      name: string;
      maxHP: integer;
      hp: integer;
      posX: integer;
      posY: integer;
      speed: integer;
      velocity: array [0..1] of integer;
    public
      constructor create(nm: string; maxHealth: integer; spd: integer);
      procedure changeHP(value: integer);
      procedure move(x: integer; y: integer);
      procedure setPos(x: integer; y: integer);
      function getHP(): integer;
      function getPosX(): integer;
      function getPosY(): integer;
      function getSpeed(): integer;
  end;

implementation


constructor TBoss.create(nm: string; maxHealth: integer; spd: integer);
begin
  name := nm;
  maxHP := maxHealth;
  hp := maxHealth;
  speed := spd;
end;

// Diese Funktion fuegt Lebenspunkte hinzu oder zieht welche ab.
procedure TBoss.changeHP(value: integer);
begin
  hp := hp + value;
  if hp < 0 then
  begin
    hp := 0;
    // some sort of dying procedure
  end;
end;

// Entity in eine bestimmte Richtung bewegen (relativ zur momentanen Position)
procedure TBoss.move(x: integer; y: integer);
begin
  posX := posX + x;
  posY := posY + y;
end;

// Absolute Position der Entity setzen
procedure TBoss.setPos(x: integer; y: integer);
begin
  posX := x;
  posY := y;
end;

function TBoss.getHP(): integer;
begin
  Result := hp;
end;

function TBoss.getPosX(): integer;
begin
  Result := posX;
end;

function TBoss.getPosY(): integer;
begin
  Result := posY;
end;

function TBoss.getSpeed(): integer;
begin
  Result := speed;
end;
end.

