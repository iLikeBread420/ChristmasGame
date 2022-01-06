unit uroom;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UEntity;

type
  roomType = (RM_INSIDE, RM_OUTSIDE);

  TRoom = class
    strict private
      kindOfRoom: roomType;
      entities: array of TEntity;
      roomnumber : integer;
    public
      constructor create(rt: roomType);
      procedure addEntity(entity: TEntity);
      function getKindOfRoom(): roomType;
  end;

implementation

constructor TRoom.create(rt: roomType);
begin
  kindOfRoom := rt;
end;

// Note: Be sure to use this procedure BEFORE CREATING a corresponding
// TRoomDisplay instance. TRoomDisplay will NOT check for changes in its
// TRoom instance.
procedure TRoom.addEntity(entity: TEntity);
begin
  setLength(entities, length(entities) + 1);
  entities[length(entities) - 1] := entity;
end;

function TRoom.getKindOfRoom(): roomType;
begin
  Result := kindOfRoom;
end;

end.

