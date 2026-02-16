import React, { createContext, useContext, useEffect, useState } from 'react';
import { RANK_PERMISSIONS, PAGE_PERMISSIONS } from '@/shared/config';

interface PlayerRankInfo {
  rank: number;
  name: string;
  charge: string;
  join_date: string;
  status: string;
}

interface PermissionsContextType {
  playerRankInfo: PlayerRankInfo | null;
  canAccessPage: (pageName: string) => boolean;
  canPerformAction: (action: string) => boolean;
  isLoading: boolean;
}

const PermissionsContext = createContext<PermissionsContextType | undefined>(undefined);

export const usePermissions = () => {
  const context = useContext(PermissionsContext);
  if (!context) {
    throw new Error('usePermissions deve ser usado dentro de um PermissionsProvider');
  }
  return context;
};

export const PermissionsProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [playerRankInfo, setPlayerRankInfo] = useState<PlayerRankInfo | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const handleMessage = (event: MessageEvent) => {
    if (event.data.type === 'playerRankInfo') {
      setPlayerRankInfo(event.data.data);
      setIsLoading(false);
    }
  };

  useEffect(() => {
    window.addEventListener('message', handleMessage);
    
    // Solicitar informações do jogador ao FiveM
    if (window.invokeNative) {
      // Enviar evento para o FiveM solicitar as informações
      window.invokeNative('sendNUIMessage', JSON.stringify({
        action: 'requestPlayerInfo'
      }));
    } else {
      // Dados padrão para desenvolvimento fora do FiveM
      const defaultData = {
        rank: 16,
        name: "Aluno",
        charge: "Policial",
        join_date: new Date().toISOString().split('T')[0],
        status: "Ativo"
      };
      setPlayerRankInfo(defaultData);
      setIsLoading(false);
    }
    
    return () => window.removeEventListener('message', handleMessage);
  }, []);

  const canAccessPage = (pageName: string): boolean => {
    if (!playerRankInfo) return false;

    const pageConfig = PAGE_PERMISSIONS[pageName as keyof typeof PAGE_PERMISSIONS];
    if (!pageConfig) return true; // Páginas não configuradas são sempre acessíveis

    // Verificar se o rank está restrito para esta página
    if (pageConfig.restrictedRanks.includes(playerRankInfo.rank)) {
      return false;
    }

    // Verificar se precisa de permissão específica
    if (pageConfig.requiredPermission) {
      return canPerformAction(pageConfig.requiredPermission);
    }

    return true;
  };

  const canPerformAction = (action: string): boolean => {
    if (!playerRankInfo) return false;

    const rankPermissions = RANK_PERMISSIONS[playerRankInfo.rank as keyof typeof RANK_PERMISSIONS];
    if (!rankPermissions) return false;

    return rankPermissions.permissions[action as keyof typeof rankPermissions.permissions] || false;
  };

  const value: PermissionsContextType = {
    playerRankInfo,
    canAccessPage,
    canPerformAction,
    isLoading,
  };

  return (
    <PermissionsContext.Provider value={value}>
      {children}
    </PermissionsContext.Provider>
  );
}; 