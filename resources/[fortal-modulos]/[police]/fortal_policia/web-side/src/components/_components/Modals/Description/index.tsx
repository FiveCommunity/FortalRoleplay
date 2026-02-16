import { usePlayerSearch, useSelectedHistory } from "@/stores/useSearch";

import { Icon } from "../../Navigation";
import { useNavigate } from "react-router-dom";
import { useSelectedPlayer } from "@/stores/useSearch";

export function Description() {
  const { current: selected } = useSelectedPlayer();
  const { current: selectedHistory } = useSelectedHistory();
  const { current: players } = usePlayerSearch();
  const navigate = useNavigate();

  // Verificar se os dados necessários existem
  if (selected < 0 || !players[selected] || selectedHistory < 0 || !players[selected]?.history?.[selectedHistory]) {
    return (
      <div className="main-informations absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.8vw]">
        <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
          <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
            <Icon.modalAnnounce />
            <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
              Erro
            </h1>
          </div>
          <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
            <p className="text-[.8vw] text-[#FFFFFF80] text-center">
              Dados não encontrados
            </p>
            <button
              onClick={() => navigate("/panel/search")}
              className="h-[2.3vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80] hover:text-white"
            >
              Fechar
            </button>
          </div>
        </div>
      </div>
    );
  }

  const historyData = players[selected].history[selectedHistory];

  return (
    <div className="main-informations absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.8vw]">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Detalhes do Histórico
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <div className="flex w-full items-center justify-between gap-[.5vw]">
            <div className="w-full">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
                Tipo
              </h1>
              <div className="flex h-[2.5vw] w-full items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
                  {historyData.type || "N/A"}
                </h1>
                <svg
                  width=".7vw"
                  height=".7vw"
                  viewBox="0 0 13 14"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M3.71429 3.97368V5.51619H9.28571V3.97368C9.28571 3.12289 8.35714 1.75 6.5 1.75C4.64286 1.75 3.71429 3.12289 3.71429 3.97368ZM1.85714 5.51619V3.97368C1.85714 2.26969 3.71429 0 6.5 0C9.28571 0 11.1429 2.26969 11.1429 3.97368V5.51619C12.1672 5.51619 13 6.20791 13 7.0587V12.4575C13 13.3083 12.1672 14 11.1429 14H1.85714C0.832813 14 0 13.3083 0 12.4575V7.0587C0 6.20791 0.832813 5.51619 1.85714 5.51619Z"
                    fill="white"
                    fillOpacity="0.05"
                  />
                </svg>
              </div>
            </div>
            <div className="w-full">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">Data</h1>
              <div className="flex h-[2.5vw] w-full items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
                  {historyData.date || "N/A"}
                </h1>
                <svg
                  width=".7vw"
                  height=".7vw"
                  viewBox="0 0 13 14"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M3.71429 3.97368V5.51619H9.28571V3.97368C9.28571 3.12289 8.35714 1.75 6.5 1.75C4.64286 1.75 3.71429 3.12289 3.71429 3.97368ZM1.85714 5.51619V3.97368C1.85714 2.26969 3.71429 0 6.5 0C9.28571 0 11.1429 2.26969 11.1429 3.97368V5.51619C12.1672 5.51619 13 6.20791 13 7.0587V12.4575C13 13.3083 12.1672 14 11.1429 14H1.85714C0.832813 14 0 13.3083 0 12.4575V7.0587C0 6.20791 0.832813 5.51619 1.85714 5.51619Z"
                    fill="white"
                    fillOpacity="0.05"
                  />
                </svg>
              </div>
            </div>
          </div>
          <div className="w-full">
            <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
              Policial
            </h1>
            <div className="flex h-[2.5vw] w-full items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
              <div>
                <div className="flex h-[1.5vw] items-center justify-center rounded-[.2vw] border border-[#FFFFFF12] bg-[#FFFFFF0D] px-[.3vw]">
                  <h1 className="text-[.8vw] text-white">
                    #{historyData.id || "N/A"}
                  </h1>
                </div>
                <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
                  {historyData.name || "N/A"}
                </h1>
              </div>
              <svg
                width=".7vw"
                height=".7vw"
                viewBox="0 0 13 14"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M3.71429 3.97368V5.51619H9.28571V3.97368C9.28571 3.12289 8.35714 1.75 6.5 1.75C4.64286 1.75 3.71429 3.12289 3.71429 3.97368ZM1.85714 5.51619V3.97368C1.85714 2.26969 3.71429 0 6.5 0C9.28571 0 11.1429 2.26969 11.1429 3.97368V5.51619C12.1672 5.51619 13 6.20791 13 7.0587V12.4575C13 13.3083 12.1672 14 11.1429 14H1.85714C0.832813 14 0 13.3083 0 12.4575V7.0587C0 6.20791 0.832813 5.51619 1.85714 5.51619Z"
                  fill="white"
                  fillOpacity="0.05"
                />
              </svg>
            </div>
          </div>
          <div className="w-full">
            <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
              Tempo/Valor
            </h1>
            <div className="flex h-[2.5vw] w-full items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
                {historyData.time || "N/A"}
              </h1>
              <svg
                width=".7vw"
                height=".7vw"
                viewBox="0 0 13 14"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M3.71429 3.97368V5.51619H9.28571V3.97368C9.28571 3.12289 8.35714 1.75 6.5 1.75C4.64286 1.75 3.71429 3.12289 3.71429 3.97368ZM1.85714 5.51619V3.97368C1.85714 2.26969 3.71429 0 6.5 0C9.28571 0 11.1429 2.26969 11.1429 3.97368V5.51619C12.1672 5.51619 13 6.20791 13 7.0587V12.4575C13 13.3083 12.1672 14 11.1429 14H1.85714C0.832813 14 0 13.3083 0 12.4575V7.0587C0 6.20791 0.832813 5.51619 1.85714 5.51619Z"
                  fill="white"
                  fillOpacity="0.05"
                />
              </svg>
            </div>
          </div>
          <div className="w-full">
            <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
              Descrição
            </h1>
            <div className="flex h-[2.5vw] w-full items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF80]">
                {historyData.description || "N/A"}
              </h1>
            </div>
          </div>
          <button
            onClick={() => navigate("/panel/search")}
            className="h-[2.3vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80] hover:text-white"
          >
            Fechar
          </button>
        </div>
      </div>
    </div>
  );
}
