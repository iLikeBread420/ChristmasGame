unit uboss;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UEntity;

type
  TBoss = class(TEntity)
    public
      constructor create(nm: string; maxHealth: integer; spd: integer);
  end;

implementation

constructor TBoss.create(nm: string; maxHealth: integer; spd: integer);
begin
  inherited create(nm, maxHealth, spd);
end;

end.
