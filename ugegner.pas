unit ugegner;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  { TGegner }
  TGegner = class
  strict private
    name: string;
    maxHP: integer;
    hp: integer;
    posX: integer;
    posY: integer;

  public
    constructor create(nm: string; maxHealth: integer);
  end;

implementation

{ TGegner }

constructor TGegner.create(nm: string; maxHealth: integer);
begin
  name := nm;
  maxHP := maxHealth;
  hp := maxHealth;
end;

end.

