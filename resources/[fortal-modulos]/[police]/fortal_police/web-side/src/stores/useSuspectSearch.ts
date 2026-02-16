import { create } from "zustand";

interface Suspect {
  id?: number;
  name: string;
  passport?: string;
  photo?: string;
}

interface SuspectSearchState {
  selectedSuspect: Suspect | null;
  setSelectedSuspect: (suspect: Suspect | null) => void;
  clearSuspect: () => void;
}

export const useSuspectSearch = create<SuspectSearchState>((set) => ({
  selectedSuspect: null,
  setSelectedSuspect: (suspect) => set({ selectedSuspect: suspect }),
  clearSuspect: () => set({ selectedSuspect: null }),
}));
