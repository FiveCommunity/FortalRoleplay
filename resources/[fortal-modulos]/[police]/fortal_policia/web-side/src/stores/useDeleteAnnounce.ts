import { create } from "zustand";

interface DeleteAnnounceState {
  isDeleting: boolean;
  announceId: string | null;
  announceTitle: string | null;
  onConfirm: ((announceId: string) => void) | null;
  setDeleteData: (announceId: string, announceTitle: string, onConfirm: (announceId: string) => void) => void;
  clearDeleteData: () => void;
  setIsDeleting: (isDeleting: boolean) => void;
}

export const useDeleteAnnounce = create<DeleteAnnounceState>((set) => ({
  isDeleting: false,
  announceId: null,
  announceTitle: null,
  onConfirm: null,
  setDeleteData: (announceId, announceTitle, onConfirm) => 
    set({ announceId, announceTitle, onConfirm }),
  clearDeleteData: () => 
    set({ announceId: null, announceTitle: null, onConfirm: null }),
  setIsDeleting: (isDeleting) => 
    set({ isDeleting }),
}));
