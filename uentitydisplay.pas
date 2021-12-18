unit uentitydisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_Image, UEntity;

type
  TEntityDisplay = class
    strict private
      mainTexture: PSDL_Texture;
      renderer: PSDL_Renderer;
      rect: TSDL_Rect;
      entity: TEntity;
    public
      constructor create(rendr: PSDL_Renderer; img: string; width: integer; height: integer; ent: TEntity);
      procedure draw();
      destructor destroy(); override;
  end;

implementation

constructor TEntityDisplay.create(rendr: PSDL_Renderer; img: string; width: integer; height: integer; ent: TEntity);
begin
  renderer := rendr;
  mainTexture := IMG_LoadTexture(renderer, PChar(img));
  rect.w := width;
  rect.h := height;
  entity := ent;
end;

procedure TEntityDisplay.draw();
begin
  rect.x := entity.getPosX;
  rect.y := entity.getPosY;
  SDL_RenderCopy(renderer, mainTexture, nil, @rect);
end;

destructor TEntityDisplay.destroy();
begin
  SDL_DestroyTexture(mainTexture);
end;

end.

