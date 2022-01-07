unit uelfdisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, UEntity, uentitydisplay;

type

  { TElfDisplay }

  TElfDisplay = class(TEntityDisplay)
    strict private
    public
      constructor create(rendr: PSDL_Renderer; w: integer; h: integer; ent: TEntity);
      procedure loadTextures(); override;
  end;

implementation

{ TElfDisplay }

constructor TElfDisplay.create(rendr: PSDL_Renderer; w: integer; h: integer;
  ent: TEntity);
begin
  inherited create(rendr, w, h, ent);
end;

procedure TElfDisplay.loadTextures();
begin
  //
end;

end.

