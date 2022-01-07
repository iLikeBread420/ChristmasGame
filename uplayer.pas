unit uplayer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UEntity;

type
  TPlayer = class(TEntity)
    public
      constructor create(nm: string; maxHealth: integer; spd: integer);
  end;

implementation

constructor TPlayer.create(nm: string; maxHealth: integer; spd: integer);
begin
  inherited create(nm, maxHealth, spd);
end;

end.

