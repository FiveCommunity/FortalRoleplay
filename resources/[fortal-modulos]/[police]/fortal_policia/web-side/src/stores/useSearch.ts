import { IPlayerSearch } from "@/types";
import { create } from "zustand";

interface PlayerSearchFrame {
  current: IPlayerSearch[];
  set: (current: IPlayerSearch[]) => void;
}

interface SelectedPlayerFrame {
  current: number;
  set: (current: number) => void
}

export const useSelectedPlayer = create<SelectedPlayerFrame>((set) => ({
  current: -1,
  set: (current: number) => set({ current }),
}));

interface SelectedHistoryFrame {
  current: number;
  set: (current: number) => void
}

export const useSelectedHistory = create<SelectedHistoryFrame>((set) => ({
  current: -1,
  set: (current: number) => set({ current }),
}));

export const usePlayerSearch = create<PlayerSearchFrame>((set) => ({
  current: [],
  set: (current: IPlayerSearch[]) => set({ current }),
}));
