unit uboss;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uentity;

type

  { TBoss }

  TBoss = class(TEntity)
    strict private

    public
      constructor create(nm: string; maxHealth: integer; spd: integer);
  end;

implementation

{ TBoss }

constructor TBoss.create(nm: string; maxHealth: integer; spd: integer);
begin
  inherited create(nm, maxHealth, spd);
end;

end.

