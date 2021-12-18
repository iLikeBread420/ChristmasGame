unit uentity;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TEntity = class
    strict private
      name: string;
      maxHP: integer;
      hp: integer;
      posX: integer;
      posY: integer;
    public
      constructor create(nm: string; max_health: integer);
      procedure changeHP(value: integer);
      procedure move(x: int; y: int);
      procedure setPos(x: int; y: int);
      function getHP(): integer;
      function getPosX(): integer;
      function getPosY(): integer;
  end;

implementation

constructor TEntity.create(nm: string; max_health: integer);
begin
  name := nm;
  maxHP := max_health;
  hp := max_health;
end;

// Diese Funktion fuegt Lebenspunkte hinzu oder zieht welche ab.
procedure TEntity.changeHP(value: integer);
begin
  hp := hp + value;
  if hp < 0 then
  begin
    hp := 0;
    // some sort of dying procedure
  end;
end;

// Entity in eine bestimmte Richtung bewegen (relativ zur momentanen Position)
procedure TEntity.move(x: int; y: int);
begin
  posX := posX + x;
  posY := posY + y;
end;

// Absolute Position der Entity setzen
procedure TEntity.setPos(x: int; y: int);
begin
  posX := x;
  posY := y;
end;

function TEntity.getHP(): integer;
begin
  Result := hp;
end;

function TEntity.getPosX(): integer;
begin
  Result := posX;
end;

function TEntity.getPosY(): integer;
begin
  Result := posY;
end;

end.

