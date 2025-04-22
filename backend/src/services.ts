import * as T from "./types.ts";
import { generateCode } from "./helper.ts";

class GroupManager {
  private groups: Map<string, Group> = new Map();

  constructor() {}

  createGroup(admin: string): T.Group {
    let code = generateCode();

    while (this.groups.has(code.id)) {
      code = generateCode();
    }

    const members = new Set<string>();
    members.add(admin);

    const groupData: T.Group = {
      code: code,
      members,
      alarm: null,
      createdAt: new Date(),
    };

    const group = new Group(groupData);
    this.groups.set(group.id, group);
    return group.data;
  }

  get(groupId: string) {
    return this.groups.get(groupId);
  }

  public refresh(groupId: string): T.Result<{ newCode: T.Code }, string> {
    const group = this.groups.get(groupId);
    if (!group) return `No Group with GroupId: ${groupId} found`;

    let code = generateCode();
    while (this.groups.has(code.id)) code = generateCode();

    group.setCode(code);

    return { newCode: code };
  }

  public memberToGroup(userId: string): Group | undefined {
    for (const group of this.groups.values()) {
      for (const member of group.getMembers()) {
        if (userId === member) {
          return group;
        }
      }
    }
    return undefined;
  }
}

class Group {
  public data: T.Group;

  constructor(self: T.Group) {
    this.data = self;
  }

  public get id() {
    return this.data.code.id;
  }

  public get isAlarm() {
    return this.data.alarm !== null;
  }

  public join(userId: string): boolean {
    if (this.data.members.has(userId)) {
      return false;
    }
    this.data.members.add(userId);
    return true;
  }

  public getMembers() {
    return this.data.members.keys().toArray();
  }

  public setCode(code: T.Code): T.Result<undefined, string> {
    if (this.getMembers().length !== 0) {
      return "Can't refresh code of non-empty group";
    }

    this.data.code = code;
    return;
  }

  setAlert(
    caller: string,
    newIsAlarm: boolean,
  ): T.Result<undefined, { msg: string }> {
    if (!this.data.members.has(caller)) {
      return { msg: "userId is not part of the group" };
    }
    if (newIsAlarm) {
      this.data.alarm = {
        id: crypto.randomUUID(),
        createdAt: new Date(),
        triggeredBy: caller,
      };
      //TODO: inform all group participants about alarm
    } else {
      this.data.alarm = null;
      //TODO: deactivate alarm of all participants
    }
  }
}

export { Group, GroupManager };
