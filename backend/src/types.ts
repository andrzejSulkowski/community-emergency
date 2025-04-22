interface Member {
  id: string;
  name: string;
}

interface Code {
  id: string;
  created_at: Date;
  expires_at: Date;
}

interface Alarm {
  id: string;
  createdAt: Date;
  triggeredBy: string;
}

interface Group {
  code: Code;
  members: Set<string>;
  createdAt: Date;
  alarm: Alarm | null;
}

type Result<T, Err> = T | Err;

export type { Alarm, Code, Group, Member, Result };
