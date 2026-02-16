import { useEffect, useState } from "react";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { usePlayerSearch } from "@/stores/useSearch";
import { usePermissions } from "@/providers/Permissions";
import { useSelectedPlayer } from "@/stores/useSearch";
import { useNavigate } from "react-router-dom";
import { useSelectedHistory } from "@/stores/useSearch";

export const Search = () => {
  const [search, setSearch] = useState("");
  const { current: selected, set: setSelected } = useSelectedPlayer();
  const { current: players, set: setPlayers } = usePlayerSearch();
  const { set: selectHistory } = useSelectedHistory();
  const { canPerformAction } = usePermissions();
  const navigate = useNavigate();

  useEffect(() => {
    Post.create("getPlayers").then((resp: any) => {
      setPlayers(resp);
    });
  }, []);

  // Listener para atualização em tempo real
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === "updatePlayerHistory") {
        if (selected >= 0 && players[selected]?.passport) {
          fetchPlayerData(players[selected].passport);
        }
      } else if (event.data.action === "photoSaved") {
        if (event.data.success) {
          // Recarregar dados do jogador para mostrar a nova foto
          if (selected >= 0 && players[selected]?.passport) {
            fetchPlayerData(players[selected].passport);
          }
        }
      }
    };

    window.addEventListener("message", handleMessage);

    return () => {
      window.removeEventListener("message", handleMessage);
    };
  }, [selected, players]);

  // Função para buscar dados específicos de um jogador
  const fetchPlayerData = async (playerId: string) => {
    try {
      const playerData = await Post.create("getPlayerData", { playerId });
      if (
        playerData &&
        typeof playerData === "object" &&
        "history" in playerData
      ) {
        // Atualizar o jogador selecionado com os dados completos
        const updatedPlayers = players.map((player) =>
          player.passport === playerId ? { ...player, ...playerData } : player,
        );
        setPlayers(updatedPlayers as any);
      }
    } catch (error) {
      console.error("Erro ao buscar dados do jogador:", error);
    }
  };

  // Função para excluir histórico
  const handleRemoveHistory = async (historyData: any) => {
    try {
      const dataToSend = {
        time: historyData.time,
        id: historyData.id,
        playerId: players[selected]?.passport,
      };

      await Post.create("removeHistory", dataToSend);

      // Atualizar dados do jogador após exclusão
      if (players[selected]?.passport) {
        fetchPlayerData(players[selected].passport);
      }
    } catch (error) {
      console.error("Erro ao excluir histórico:", error);
    }
  };

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: { pathname: location.pathname, search: location.search } },
    });
  };

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.search className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          {selected >= 0 ? "Perfil" : "Buscar"}
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <h1 className="text-[.8vw] text-[#FFFFFF4D]">
          Esses dados são confidenciais. Não compartilhe com terceiros.
        </h1>
        {selected < 0 ? (
          <>
            <div className="mt-[.8vw] flex h-[2.5vw] w-full items-center gap-[.8vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
              <Icon.search className="text-white/60 drop-shadow-[0_0_15px_#FFFFFF]" />
              <input
                placeholder="Buscar (Nome, ID)"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="h-full w-[52vw] bg-transparent text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
                type="text"
              />
            </div>
            <div className="mt-[1vw] h-[25vw] w-full">
              {search && (
                <div className="h-[2vw]">
                  <h1 className="text-[.8vw] text-[#FFFFFF73]">
                    Resultados encontrados para
                    <span className="capitalize text-[#FFFFFFB2]">
                      {" "}
                      '{search}'
                    </span>
                  </h1>
                </div>
              )}
              <div className="announce-scroll grid h-[calc(100%-2vw)] w-full grid-cols-3 gap-[.5vw] overflow-auto pr-[.5vw]">
                {search && (
                  <>
                    {players
                      .filter((data) => {
                        const lowerSearch = search.toLowerCase();
                        return (
                          data.name.toLowerCase().includes(lowerSearch) ||
                          String(data.passport).includes(lowerSearch)
                        );
                      })
                      .map((data) => {
                        // Encontrar o índice real no array original
                        const originalIndex = players.findIndex(
                          (player) => player.passport === data.passport,
                        );

                        return (
                          <div
                            onClick={() => {
                              setSelected(originalIndex);
                              // Buscar dados específicos do jogador
                              fetchPlayerData(data.passport);
                            }}
                            key={data.passport}
                            className="flex h-[6vw] w-full items-center gap-[1vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section p-[.5vw]"
                          >
                            <div className="relative flex h-full w-[5vw] items-center justify-center rounded-[.2vw]">
                              <img
                                src={
                                  data.photo
                                    ? data.photo
                                    : "./default-profile.png"
                                }
                                className="h-full w-full"
                                alt=""
                              />
                            </div>
                            <div>
                              <p className="text-[.7vw] text-[#FFFFFF80]">
                                Nome
                              </p>
                              <h1 className="text-[.8vw] text-white">
                                {data.name}
                              </h1>
                              <p className="text-[.7vw] text-[#FFFFFF80]">
                                Passaporte
                              </p>
                              <h1 className="text-[.8vw] text-white">
                                {data.passport}
                              </h1>
                            </div>
                          </div>
                        );
                      })}
                  </>
                )}
              </div>
            </div>
          </>
        ) : (
          <div>
            <button
              onClick={() => {
                setSelected(-1);
                setSearch("");
              }}
              className="mt-[.5vw] flex h-[2.3vw] w-full items-center rounded-[.3vw] bg-[#FFFFFF05] text-[.8vw] text-white"
            >
              <Icon.close />
              Voltar
            </button>
            <div className="mt-[.5vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section">
              <div className="flex h-[2vw] w-full items-center bg-[#FFFFFF05] px-[1vw]">
                <h1 className="text-[.8vw] text-[#FFFFFFA6]">
                  Informações de{" "}
                  <span className="text-white">
                    '{players[selected]?.name}'
                  </span>
                </h1>
              </div>
              {(() => {
                return null;
              })()}

              <div className="flex h-[10vw] w-full items-center p-[.5vw]">
                <div className="relative flex h-full w-[9vw] items-center justify-center rounded-[.3vw]">
                  <button
                    onClick={() => {
                      Post.create("startPhotoCapture", {
                        targetUserId: players[selected].passport,
                      });
                    }}
                    className="absolute bottom-[-.7vw] left-1/2 transform -translate-x-1/2 flex h-[1.8vw] w-[1.8vw] items-center justify-center rounded-[.4vw] border border-[#FFFFFF26] bg-[#15161CBF]"
                  >
                    <svg
                      width=".8vw"
                      height=".8vw"
                      viewBox="0 0 15 13"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M15 3.25V11.6071C15 12.3761 14.3701 13 13.5938 13H1.40625C0.629883 13 0 12.3761 0 11.6071V3.25C0 2.48103 0.629883 1.85714 1.40625 1.85714H3.98438L4.34473 0.902455C4.5498 0.359821 5.07422 0 5.66016 0H9.33691C9.92285 0 10.4473 0.359821 10.6523 0.902455L11.0156 1.85714H13.5938C14.3701 1.85714 15 2.48103 15 3.25ZM11.0156 7.42857C11.0156 5.50759 9.43945 3.94643 7.5 3.94643C5.56055 3.94643 3.98438 5.50759 3.98438 7.42857C3.98438 9.34955 5.56055 10.9107 7.5 10.9107C9.43945 10.9107 11.0156 9.34955 11.0156 7.42857ZM10.0781 7.42857C10.0781 8.83594 8.9209 9.98214 7.5 9.98214C6.0791 9.98214 4.92188 8.83594 4.92188 7.42857C4.92188 6.02121 6.0791 4.875 7.5 4.875C8.9209 4.875 10.0781 6.02121 10.0781 7.42857Z"
                        fill="white"
                      />
                    </svg>
                  </button>
                  <img
                    src={
                      players[selected]?.photo
                        ? players[selected]?.photo
                        : "./default-profile.png"
                    }
                    className="h-full w-full"
                    alt=""
                  />
                </div>
                <div className="ml-[.5vw] grid h-full w-[calc(100%-10vw)] grid-cols-2 gap-[.3vw]">
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">NOME</h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.name}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">
                        PASSAPORTE
                      </h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.passport}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">TELEFONE</h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.register}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">IDADE</h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.years}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">
                        PROCURADO
                      </h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.wanted}
                    </p>
                  </div>
                  <button className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">
                        PORTE DE ARMAS
                      </h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.size}
                    </p>
                  </button>
                </div>
              </div>
            </div>
            <div className="mt-[.5vw] h-[13vw] w-full">
              <div className="flex w-full items-center justify-between gap-[.5vw]">
                <div className="flex h-[2.5vw] w-full items-center justify-center rounded-[.2vw] bg-[#FFFFFF05] text-[.8vw] uppercase text-white">
                  Histórico
                </div>
              </div>
              <div className="mt-[.5vw] h-[calc(100%-3vw)] w-full overflow-auto rounded-[.3vw] border border-[#FFFFFF0D] bg-[#FFFFFF08]">
                <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF14] px-[.5vw]">
                  <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">Tipo</h1>
                  <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">Data</h1>
                  <h1 className="w-[9vw] text-[.8vw] text-[#FFFFFFA6]">
                    Policial
                  </h1>
                  <h1 className="w-[6vw] text-[.8vw] text-[#FFFFFFA6]">
                    Descrição
                  </h1>
                  <h1 className="w-[7vw] text-center text-[.8vw] text-[#FFFFFFA6]">
                    Tempo/Valor
                  </h1>
                  <h1 className="w-[3vw] text-center text-[.8vw] text-[#FFFFFFA6]">
                    Ações
                  </h1>
                </div>
                {players[selected]?.history?.map((data: any, index: number) => (
                  <div
                    key={index}
                    className="flex h-[2.4vw] w-full items-center justify-between border-b border-solid border-[#FFFFFF14] px-[.5vw]"
                  >
                    <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">
                      {data.type}
                    </h1>
                    <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">
                      {data.date}
                    </h1>
                    <h1 className="w-[9vw] text-[.8vw] text-[#FFFFFFA6]">
                      <span className="mr-[.3vw] rounded-[.3vw] border border-[#FFFFFF12] bg-[#FFFFFF0D] px-[.3vw] py-[.1vw] text-[.7vw] text-white">
                        #{data.id}
                      </span>
                      <span className="text-[.8vw] text-white">
                        {data.name}
                      </span>
                    </h1>
                    <button 
                      onClick={(e) => {
                        e.stopPropagation();
                        selectHistory(index);
                        openModal("/panel/search/info");
                      }}
                      className="w-[6vw] text-left"
                    >
                      <h1 className="text-[.8vw] text-[#FFFFFFA6] hover:text-white transition-colors">
                        {data.description.length > 15
                          ? data.description.slice(0, 15) + "..."
                          : data.description}
                      </h1>
                    </button>
                    <h1 className="w-[7vw] text-center text-[.8vw] text-[#FFFFFFA6]">
                      {data.time}
                    </h1>
                    <div className="w-[3vw] text-center">
                      {canPerformAction("canEditHistory") && (
                        <button
                          onClick={(e) => {
                            e.stopPropagation();
                            handleRemoveHistory(data);
                          }}
                          className="text-[.8vw] text-[#DE5757C9] transition-colors hover:text-[#DE575790]"
                        >
                          Excluir
                        </button>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
