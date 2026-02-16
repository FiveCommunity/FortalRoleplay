// Configuração das páginas e suas permissões
export const PAGE_PERMISSIONS = {
  home: {
    name: "home",
    label: "Início",
    requiredPermission: null, // Sempre acessível
    restrictedRanks: [] as number[]
  },
  search: {
    name: "search",
    label: "Busca",
    requiredPermission: "canSearch",
    restrictedRanks: [] as number[]
  },
  locked: {
    name: "locked",
    label: "Presos",
    requiredPermission: "canLocked",
    restrictedRanks: [] as number[]
  },
  fine: {
    name: "fine",
    label: "Multas",
    requiredPermission: "canFine",
    restrictedRanks: [] as number[]
  },
  wanted: {
    name: "wanted",
    label: "Procurados",
    requiredPermission: "canWanted",
    restrictedRanks: [] as number[]
  },
  occurrence: {
    name: "occurrence",
    label: "B.O.s",
    requiredPermission: null,
    restrictedRanks: [14, 15, 16] as number[] // Soldados e Aluno não podem ver
  },
  members: {
    name: "members",
    label: "Membros",
    requiredPermission: "canViewMembers",
    restrictedRanks: [14, 15, 16] as number[] // Soldados e Aluno não podem ver
  }
};

// Mapeamento de ranks para nomes
export const RANK_NAMES = {
  1: "Secretário",
  2: "Comandante",
  3: "Coronel",
  4: "Tenente Coronel",
  5: "Major",
  6: "Capitão",
  7: "Tenente",
  8: "2º Tenente",
  9: "Sub Tenente",
  10: "1º Sargento",
  11: "2º Sargento",
  12: "3º Sargento",
  13: "Cabo",
  14: "Soldado de 1ª Classe",
  15: "Soldado de 2ª Classe",
  16: "Aluno"
};

// Configuração de permissões por rank
export const RANK_PERMISSIONS = {
  1: { // Secretário
    restrictedPages: [],
    permissions: {
      canHire: true,
      canFire: true,
      canPromote: true,
      canDemote: true,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: true,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  2: { // Comandante
    restrictedPages: [],
    permissions: {
      canHire: true,
      canFire: true,
      canPromote: true,
      canDemote: true,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: true,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  3: { // Coronel
    restrictedPages: [],
    permissions: {
      canHire: true,
      canFire: true,
      canPromote: true,
      canDemote: true,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: true,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  4: { // Tenente Coronel
    restrictedPages: [],
    permissions: {
      canHire: true,
      canFire: true,
      canPromote: true,
      canDemote: true,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: true,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  5: { // Major
    restrictedPages: [],
    permissions: {
      canHire: true,
      canFire: true,
      canPromote: true,
      canDemote: true,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  6: { // Capitão
    restrictedPages: [],
    permissions: {
      canHire: true,
      canFire: true,
      canPromote: true,
      canDemote: true,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  7: { // Tenente
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  8: { // 2º Tenente
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  9: { // Sub Tenente
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  10: { // 1º Sargento
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  11: { // 2º Sargento
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  12: { // 3º Sargento
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: true,
      canDeleteAnnounce: true,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  13: { // Cabo
    restrictedPages: [],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: false,
      canDeleteAnnounce: false,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: true,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  14: { // Soldado de 1ª Classe
    restrictedPages: ["occurrence"],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: false,
      canDeleteAnnounce: false,
      canWanted: false,
      canRemoveWanted: false,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: false,
      canEditMembers: false,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  15: { // Soldado de 2ª Classe
    restrictedPages: ["occurrence"],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: false,
      canDeleteAnnounce: false,
      canWanted: false,
      canRemoveWanted: false,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: false,
      canEditMembers: false,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  },
  16: { // Aluno
    restrictedPages: ["members", "occurrence"],
    permissions: {
      canHire: false,
      canFire: false,
      canPromote: false,
      canDemote: false,
      canAnnounce: false,
      canDeleteAnnounce: false,
      canWanted: true,
      canRemoveWanted: true,
      canViewHistory: true,
      canEditHistory: false,
      canViewStats: true,
      canViewMembers: true,
      canEditMembers: false,
      canPrison: true,
      canFine: true,
      canSearch: true,
      canLocked: true
    }
  }
};
