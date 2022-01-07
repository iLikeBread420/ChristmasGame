unit uelf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UEntity;

  Type

    { TElf }

    TElf = class(TEntity)
    strict private
      kindofnpc : string;       //important cause one elf wont be an enemy but and npc to talk to in room 2
    public
      constructor create(nm: string; maxHealth: integer; spd: integer; konpc : string);
      function getKindofNpc() : string;
    end;

implementation

{ TElf }

constructor TElf.create(nm: string; maxHealth: integer; spd: integer;konpc : string);
begin
  inherited create(nm, maxHealth, spd);
  konpc := kindofnpc;
end;

function TElf.getKindofNpc(): string;
begin
  Result := kindofnpc;
end;

end.

