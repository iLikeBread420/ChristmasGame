unit ubossdisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uentitydisplay;

type

  { TBossDisplay }

  TBossDisplay = class(TEntityDisplay)
    strict private
    public
      constructor create(rendr: PSDL_Renderer; w: integer; h: integer; ent: TEntity);
      procedure loadTextures(); override;
  end;

implementation

{ TBossDisplay }

constructor TBossDisplay.create(rendr: PSDL_Renderer; w: integer; h: integer;
  ent: TEntity);
begin
  inherited create(rendr, w, h, ent);
end;

procedure TBossDisplay.loadTextures();
begin
  //
end;

end.

