import { IMembers } from "@/types";
import { create } from "zustand";

interface MemberFrame {
  current: IMembers[];
  set: (members: IMembers[]) => void;
}

interface SelectedUserFrame {
  current: number;
  set: (current: number) => void;
}

export const useMember = create<MemberFrame>((set) => ({
  current: [],
  set: (members) => set({ current: members }),
}));

export const useSelectedMember = create<SelectedUserFrame>((set) => ({
  current: 0,
  set: (current: number) => set({ current }),
}));
