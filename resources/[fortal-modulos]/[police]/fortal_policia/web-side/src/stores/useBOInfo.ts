import { create } from "zustand";

interface BOInfoState {
  isOpen: boolean;
  boData: any | null;
  openModal: (boData: any) => void;
  closeModal: () => void;
}

export const useBOInfo = create<BOInfoState>((set) => ({
  isOpen: false,
  boData: null,
  openModal: (boData) => set({ isOpen: true, boData }),
  closeModal: () => set({ isOpen: false, boData: null }),
}));
