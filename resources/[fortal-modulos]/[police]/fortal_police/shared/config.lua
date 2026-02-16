Config = {}

-- Configurações gerais
Config.Command = 'police' -- Comando para abrir o painel
Config.DefaultPermission = 'Police' -- Permissão padrão para policiais

Config.policeItems = {
   "defibrillator",
   "vest",
   "gsrkit",
   "gdtkit",
   "barrier",
   "attachsFlashlight",
   "attachsCrosshair",
   "attachsSilencer",
   "attachsMagazine",
   "attachsGrip",
   "WEAPON_SMG",
   "handcuff",
   "WEAPON_PUMPSHOTGUN",
   "WEAPON_CARBINERIFLE",
   "WEAPON_CARBINERIFLE_MK2",
   "WEAPON_STUNGUN",
   "WEAPON_COMBATPISTOL",
   "WEAPON_NIGHTSTICK",
   "WEAPON_PISTOL_AMMO",
   "WEAPON_SMG_AMMO",
   "WEAPON_RIFLE_AMMO",
   "WEAPON_SHOTGUN_AMMO",
   "badge07"
}

-- Configurações de patentes hierárquicas (do maior para o menor)
Config.Hierarchy = {
    [1] = { 
        name = "Secretario", 
        label = "Secretário",
        salary = 15000, -- Salário mensal
        restrictedPages = {}, -- Pode ver todas as páginas
        permissions = {
            canHire = true, -- Pode contratar
            canFire = true, -- Pode demitir
            canPromote = true, -- Pode promover
            canDemote = true, -- Pode rebaixar
            canAnnounce = true, -- Pode fazer anúncios
            canWanted = true, -- Pode colocar procurado
            canRemoveWanted = true, -- Pode remover procurado
            canViewHistory = true, -- Pode ver histórico
            canEditHistory = true, -- Pode editar histórico
            canViewStats = true, -- Pode ver estatísticas
            canViewMembers = true, -- Pode ver membros
            canEditMembers = true, -- Pode editar membros
            canPrison = true, -- Pode prender
            canFine = true, -- Pode multar
            canSearch = true, -- Pode buscar
            canLocked = true -- Pode ver presos
        }
    },
    [2] = { 
        name = "Comandante", 
        label = "Comandante",
        salary = 13000,
        restrictedPages = {},
        permissions = {
            canHire = true, -- Pode contratar
            canFire = true, -- Pode demitir
            canPromote = true, -- Pode promover
            canDemote = true, -- Pode rebaixar
            canAnnounce = true, -- Pode fazer anúncios
            canWanted = true, -- Pode colocar procurado
            canRemoveWanted = true, -- Pode remover procurado
            canViewHistory = true, -- Pode ver histórico
            canEditHistory = true, -- Pode editar histórico
            canViewStats = true, -- Pode ver estatísticas
            canViewMembers = true, -- Pode ver membros
            canEditMembers = true, -- Pode editar membros
            canPrison = true, -- Pode prender
            canFine = true, -- Pode multar
            canSearch = true, -- Pode buscar
            canLocked = true -- Pode ver presos
        }
    },
    [3] = { 
        name = "Coronel", 
        label = "Coronel",
        salary = 12000,
        restrictedPages = {},
        permissions = {
            canHire = true, -- Pode contratar
            canFire = true, -- Pode demitir
            canPromote = true, -- Pode promover
            canDemote = true, -- Pode rebaixar
            canAnnounce = true, -- Pode fazer anúncios
            canWanted = true, -- Pode colocar procurado
            canRemoveWanted = true, -- Pode remover procurado
            canViewHistory = true, -- Pode ver histórico
            canEditHistory = true, -- Pode editar histórico
            canViewStats = true, -- Pode ver estatísticas
            canViewMembers = true, -- Pode ver membros
            canEditMembers = true, -- Pode editar membros
            canPrison = true, -- Pode prender
            canFine = true, -- Pode multar
            canSearch = true, -- Pode buscar
            canLocked = true -- Pode ver presos
        }
    },
    [4] = { 
        name = "TenenteCoronel", 
        label = "Tenente Coronel",
        salary = 11000,
        restrictedPages = {},
        permissions = {
            canHire = true, -- Pode contratar
            canFire = true, -- Pode demitir
            canPromote = true, -- Pode promover
            canDemote = true, -- Pode rebaixar
            canAnnounce = true, -- Pode fazer anúncios
            canWanted = true, -- Pode colocar procurado
            canRemoveWanted = true, -- Pode remover procurado
            canViewHistory = true, -- Pode ver histórico
            canEditHistory = true, -- Pode editar histórico
            canViewStats = true, -- Pode ver estatísticas
            canViewMembers = true, -- Pode ver membros
            canEditMembers = true, -- Pode editar membros
            canPrison = true, -- Pode prender
            canFine = true, -- Pode multar
            canSearch = true, -- Pode buscar
            canLocked = true -- Pode ver presos
        }
    },
    [5] = { 
        name = "Major", 
        label = "Major",
        salary = 10000,
        restrictedPages = {},
        permissions = {
            canHire = true, -- Pode contratar
            canFire = true, -- Pode demitir
            canPromote = true, -- Pode promover
            canDemote = true, -- Pode rebaixar
            canAnnounce = true, -- Pode fazer anúncios
            canWanted = true, -- Pode colocar procurado
            canRemoveWanted = true, -- Pode remover procurado
            canViewHistory = true, -- Pode ver histórico
            canEditHistory = false, -- Pode editar histórico
            canViewStats = true, -- Pode ver estatísticas
            canViewMembers = true, -- Pode ver membros
            canEditMembers = true, -- Pode editar membros
            canPrison = true, -- Pode prender
            canFine = true, -- Pode multar
            canSearch = true, -- Pode buscar
            canLocked = true -- Pode ver presos
        }
    },
    [6] = { 
        name = "Capitao", 
        label = "Capitão",
        salary = 9000,
        restrictedPages = {},
        permissions = {
            canHire = true,
            canFire = true,
            canPromote = true,
            canDemote = true,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [7] = { 
        name = "Tenente", 
        label = "Tenente",
        salary = 8000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [8] = { 
        name = "2Tenente", 
        label = "2º Tenente",
        salary = 7000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [9] = { 
        name = "SubTenente", 
        label = "Sub Tenente",
        salary = 6000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [10] = { 
        name = "1Sagt", 
        label = "1º Sargento",
        salary = 5000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [11] = { 
        name = "2Sagt", 
        label = "2º Sargento",
        salary = 4500,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [12] = { 
        name = "3Sagt", 
        label = "3º Sargento",
        salary = 4000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [13] = { 
        name = "Cabo", 
        label = "Cabo",
        salary = 3500,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = false,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [14] = { 
        name = "Soldado1Classe", 
        label = "Soldado de 1ª Classe",
        salary = 3500,
        restrictedPages = {
            "occurrence" -- Não pode ver página de B.O.s
        },
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = false,
            canWanted = false,
            canRemoveWanted = false,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = false,
            canEditMembers = false,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [15] = { 
        name = "Soldado2Classe", 
        label = "Soldado de 2ª Classe",
        salary = 3000,
        restrictedPages = {
            "occurrence" -- Não pode ver página de B.O.s
        },
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = false,
            canWanted = false,
            canRemoveWanted = false,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = false,
            canEditMembers = false,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [16] = { 
        name = "Aluno", 
        label = "Aluno",
        salary = 2000,
        restrictedPages = {
            "members", -- Não pode ver página de membros
            "occurrence", -- Não pode ver página de B.O.s
        },
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = false,
            canWanted = false,
            canRemoveWanted = false,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = false,
            canEditMembers = false,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    }
}

-- Configurações de prisões
Config.Prison = {
    { art = 121, description = 'Homicídio simples', price = 15000, months = 30 },
    { art = 201, description = 'Homicídio tentado ou lesão corporal grave', price = 3000, months = 20 },
    { art = 202, description = 'Roubo a loja de departamento', price = 5000, months = 25 },
    { art = 203, description = 'Roubo a loja de armas', price = 5000, months = 23 },
    { art = 204, description = 'Assalto ao Banco Fleeca', price = 10000, months = 35 },
    { art = 205, description = 'Assalto ao Banco de Paleto', price = 13000, months = 40 },
    { art = 206, description = 'Assalto ao Banco Central', price = 15000, months = 50 },
    { art = 207, description = 'Tentativa de fuga policial', price = 2000, months = 20 },
    { art = 208, description = 'Posse de itens ilegais', price = 1000, months = 20 },
    { art = 209, description = 'Porte de arma - Calibre baixo', price = 2000, months = 20 },
    { art = 210, description = 'Porte de arma - Calibre médio', price = 3000, months = 30 },
    { art = 211, description = 'Porte de arma - Calibre alto', price = 5000, months = 50 },
    { art = 212, description = 'Porte de arma branca', price = 500, months = 10 },
    { art = 213, description = 'Roubo a pedestre', price = 1000, months = 20 },
    { art = 214, description = 'Roubo de porta-malas', price = 1000, months = 10 },
    { art = 215, description = 'Furto de veículo', price = 1000, months = 20 },
    { art = 216, description = 'Ameaça', price = 1000, months = 10 },
    { art = 217, description = 'Roubo', price = 2000, months = 30 },
    { art = 218, description = 'Roubo de viatura', price = 5000, months = 50 },
    { art = 219, description = 'Associação criminosa', price = 2000, months = 20 },
    { art = 220, description = 'Caça ilegal', price = 1500, months = 15 },
    { art = 221, description = 'Corrida ilegal', price = 2000, months = 25 },
    { art = 223, description = 'Desacato', price = 2000, months = 30 },
    { art = 224, description = 'Desobediência', price = 1000, months = 20 },
    { art = 225, description = 'Estelionato', price = 2000, months = 30 },
    { art = 226, description = 'Falsidade ideológica', price = 2000, months = 15 },
    { art = 227, description = 'Falso testemunho', price = 2000, months = 10 },
    { art = 228, description = 'Furto', price = 2000, months = 15 },
    { art = 229, description = 'Invasão de propriedade', price = 2000, months = 25 },
    { art = 230, description = 'Invasão de propriedade pública', price = 5000, months = 80 },
    { art = 231, description = 'Lesão corporal', price = 1000, months = 15 },
    { art = 233, description = 'Obstrução da justiça', price = 3500, months = 20 },
    { art = 239, description = 'Ocultação facial', price = 15000, months = 15 },
    { art = 240, description = 'Porte ilegal de arma - Classe 01', price = 2000, months = 25 },
    { art = 241, description = 'Porte ilegal de arma - Classe 02', price = 4000, months = 30 },
    { art = 242, description = 'Produtos ilícitos', price = 1000, months = 25 },
    { art = 243, description = 'Receptação', price = 1500, months = 30 },
    { art = 244, description = 'Uso de roupas policiais', price = 15000, months = 0 },
    { art = 245, description = 'Sequestro', price = 2500, months = 20 },
    { art = 246, description = 'Suborno', price = 3000, months = 25 },
    { art = 247, description = 'Tentativa de homicídio', price = 2500, months = 15 },
    { art = 248, description = 'Tentativa de homicídio a oficial', price = 2500, months = 15 },
    { art = 249, description = 'Terrorismo', price = 25000, months = 50 },
    { art = 250, description = 'Tráfico de drogas', price = 3500, months = 30 },
    { art = 251, description = 'Tráfico de munição', price = 5500, months = 30 }
}


-- Configurações de multas
Config.Fines = {
    { art = 301, description = 'Estacionar em local proibido', price = 2500 },
    { art = 302, description = 'Velocidade acima do permitido', price = 2500 },
    { art = 303, description = 'Direção perigosa', price = 1500 },
    { art = 304, description = 'Pousar em local proibido ou sem designação', price = 30000 },
    { art = 305, description = 'Manobra imprudente com aeronave', price = 20000 },
    { art = 306, description = 'Veículo abandonado', price = 1000 },
    { art = 307, description = 'Trafegar na contramão', price = 1500 },
    { art = 308, description = 'Dano ao patrimônio', price = 2500 },
    { art = 309, description = 'Veículo danificado', price = 1500 },
    { art = 310, description = 'Bloquear ou danificar viatura', price = 5000 }
}


-- Configurações de tempo
Config.TimeMultiplier = 1000 -- 1 segundo real = 1000ms de prisão
