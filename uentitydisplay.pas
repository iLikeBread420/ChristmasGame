unit uentitydisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_Image;

type
  TEntityDisplay = class
    strict private
      mainTexture: PSDL_Texture;
      renderer: PSDL_Renderer;
      rect: TSDL_Rect;
      entity: TEntity;
    public
      constructor create(rendr: PSDL_Renderer; img: string, width: int; height: int);
      procedure draw();
      destructor destroy(); override;
  end;

implementation

constructor TEntityDisplay.create(rendr: PSDL_Renderer; img: string, width: int; height: int);
begin
  renderer := rendr;
  mainTexture := IMG_LoadTexture(renderer, img);
  rect.w := width;
  rect.h := height;
end;

procedure TEntityDisplay.draw();
begin
  rect.x := entity.getPosX;
  rect.y := entity.getPosY;
  SDL_RenderCopy(renderer, mainTexture, nil, @rect);
end;

end.

