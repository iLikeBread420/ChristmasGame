unit uroom;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UEntity;

type
  roomType = (RM_INSIDE1, RM_INSIDE2, RM_OUTSIDE);

  { TRoom }

  TRoom = class
    strict private
      kindOfRoom: roomType;
      entities: array of TEntity;
      roomnumber : integer;
    public
      constructor create(rt: roomType; rn : integer);
      procedure addEntity(entity: TEntity);
      function getKindOfRoom(): roomType;
      function getRoomnumber() : integer;
  end;

implementation

constructor TRoom.create(rt: roomType; rn : integer);
begin
  kindOfRoom := rt;
  roomnumber := rn;
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

function TRoom.getRoomnumber(): integer;
begin
  Result := Roomnumber;
end;

end.

