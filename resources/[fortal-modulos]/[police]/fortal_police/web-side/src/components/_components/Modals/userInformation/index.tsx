import { Icon } from "../../Navigation";
import { useMember } from "@/stores/useMember";
import { useNavigate } from "react-router-dom";
import { useSelectedMember } from "@/stores/useMember";
import { useEffect, useState } from "react";

interface OfficerStats {
  arrests_made?: number;
  fines_applied?: number;
  total_fines_value?: number;
  total_working_hours?: number;
  vehicles_seized?: number;
  reports_registered?: number;
  phone?: string;
  passport?: string;
  age?: string;
  weapon_license?: string;
  wanted_status?: string;
}

export function UserInformation() {
  const { current: selected } = useSelectedMember();
  const { current: members } = useMember();
  const navigate = useNavigate();
  const [officerStats, setOfficerStats] = useState<OfficerStats>({});
  const [isLoadingStats, setIsLoadingStats] = useState(true);

  // Buscar estatísticas do oficial quando o modal abrir
  useEffect(() => {
    if (selected !== null && members[selected]) {
      setIsLoadingStats(true);
      
      // Chamar o callback getOfficerStats
      fetch('https://fortal_police/getOfficerStats', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          officerId: members[selected]?.id
        }),
      })
      .then(response => response.json())
      .then(data => {
        setOfficerStats(data);
        setIsLoadingStats(false);
      })
      .catch(error => {
        console.error('[DEBUG FRONTEND] Erro ao buscar estatísticas:', error);
        setIsLoadingStats(false);
      });
    }
  }, [selected, members]);

  return (
    <div className="main-information absolute left-0 top-0 z-50 flex h-full w-full flex-col items-center justify-center gap-[.5vw] rounded-[.8vw]">
      <div className="section w-[55vw] rounded-[.3vw] border border-[#FFFFFF08]">
        <div className="flex h-[2vw] w-full items-center bg-[#FFFFFF05] px-[1vw]">
          <h1 className="text-[.8vw] text-[#FFFFFFA6]">
            Informações de{" "}
            <span className="text-white">'{members[selected]?.name}'</span>
          </h1>
        </div>

        <div className="flex h-[10vw] w-full items-center p-[.5vw]">
          <div className="flex h-full w-[10vw] items-center justify-center rounded-[.3vw]">
            <img
              src={
                members[selected]?.photo
                  ? members[selected]?.photo
                  : "./default-profile.png"
              }
              className="h-full w-full"
              alt=""
            />
          </div>
          <div className="ml-[.5vw] grid h-full w-[calc(100%-10vw)] grid-cols-2 gap-[.3vw]">
            <div className="section flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw]">
              <div className="flex items-center gap-[.5vw]">
                <Icon.list2 />
                <h1 className="text-[.8vw] text-[#FFFFFF73]">NOME</h1>
              </div>
              <p className="text-[.8vw] capitalize text-white">
                {members[selected]?.name}
              </p>
            </div>
            <div className="section flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw]">
              <div className="flex items-center gap-[.5vw]">
                <Icon.list2 />
                <h1 className="text-[.8vw] text-[#FFFFFF73]">PASSAPORTE</h1>
              </div>
              <p className="text-[.8vw] capitalize text-white">
                {officerStats.passport || "Não informado"}
              </p>
            </div>
            <div className="section flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw]">
              <div className="flex items-center gap-[.5vw]">
                <Icon.list2 />
                <h1 className="text-[.8vw] text-[#FFFFFF73]">TELEFONE</h1>
              </div>
              <p className="text-[.8vw] capitalize text-white">
                {officerStats.phone || "Não informado"}
              </p>
            </div>
            <div className="section flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw]">
              <div className="flex items-center gap-[.5vw]">
                <Icon.list2 />
                <h1 className="text-[.8vw] text-[#FFFFFF73]">IDADE</h1>
              </div>
              <p className="text-[.8vw] capitalize text-white">
                {officerStats.age || "Não informado"}
              </p>
            </div>
            <div className="section flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw]">
              <div className="flex items-center gap-[.5vw]">
                <Icon.list2 />
                <h1 className="text-[.8vw] text-[#FFFFFF73]">PROCURADO</h1>
              </div>
              <p className="text-[.8vw] capitalize text-white">
                {officerStats.wanted_status || "Não"}
              </p>
            </div>
            <button className="section flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw]">
              <div className="flex items-center gap-[.5vw]">
                <Icon.list2 />
                <h1 className="text-[.8vw] text-[#FFFFFF73]">PORTE DE ARMAS</h1>
              </div>
              <p className="text-[.8vw] capitalize text-white">
                {officerStats.weapon_license || "Não informado"}
              </p>
            </button>
          </div>
        </div>
      </div>
      <div className="section w-[55vw] rounded-[.3vw] border border-[#ffffff08]">
        <div className="flex h-[2vw] w-full items-center bg-[#FFFFFF05] px-[1vw]">
          <h1 className="text-[.8vw] text-[#FFFFFFA6]">
            Estatísticas de
            <span className="text-white"> '{members[selected]?.name}'</span>
          </h1>
        </div>
        <div className="grid w-full grid-cols-3 gap-[.5vw] p-[.5vw]">
          <div className="section flex h-[3.38vw] w-[17.44vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] px-[.5vw]">
            <svg
              width="1.5vw"
              height="1.5vw"
              viewBox="0 0 16 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M2.66667 19.0312C2.3 19.0312 2 18.7359 2 18.375V2.625C2 2.26406 2.3 1.96875 2.66667 1.96875H9.33333V5.25C9.33333 5.97598 9.92917 6.5625 10.6667 6.5625H14V18.375C14 18.7359 13.7 19.0312 13.3333 19.0312H2.66667ZM2.66667 0C1.19583 0 0 1.17715 0 2.625V18.375C0 19.8229 1.19583 21 2.66667 21H13.3333C14.8042 21 16 19.8229 16 18.375V6.33691C16 5.63965 15.7208 4.97109 15.2208 4.47891L11.4458 0.766992C10.9458 0.274805 10.2708 0 9.5625 0H2.66667ZM5 10.5C4.44583 10.5 4 10.9389 4 11.4844C4 12.0299 4.44583 12.4688 5 12.4688H11C11.5542 12.4688 12 12.0299 12 11.4844C12 10.9389 11.5542 10.5 11 10.5H5ZM5 14.4375C4.44583 14.4375 4 14.8764 4 15.4219C4 15.9674 4.44583 16.4062 5 16.4062H11C11.5542 16.4062 12 15.9674 12 15.4219C12 14.8764 11.5542 14.4375 11 14.4375H5Z"
                fill="white"
                fill-opacity="0.45"
              />
            </svg>
            <div className="text-start">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF73]">
                Prisões Realizadas
              </h1>
              <p className="text-[.8vw] font-[500] text-[#FFFFFFD9]">
                {isLoadingStats ? "Carregando..." : 
                  officerStats.arrests_made && officerStats.arrests_made > 0
                    ? `${officerStats.arrests_made} Prisões`
                    : "Nenhuma"}
              </p>
            </div>
          </div>
          <div className="section flex h-[3.38vw] w-[17.44vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] px-[.5vw]">
            <svg
              width="1.5vw"
              height="1.5vw"
              viewBox="0 0 16 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M2.66667 19.0312C2.3 19.0312 2 18.7359 2 18.375V2.625C2 2.26406 2.3 1.96875 2.66667 1.96875H9.33333V5.25C9.33333 5.97598 9.92917 6.5625 10.6667 6.5625H14V18.375C14 18.7359 13.7 19.0312 13.3333 19.0312H2.66667ZM2.66667 0C1.19583 0 0 1.17715 0 2.625V18.375C0 19.8229 1.19583 21 2.66667 21H13.3333C14.8042 21 16 19.8229 16 18.375V6.33691C16 5.63965 15.7208 4.97109 15.2208 4.47891L11.4458 0.766992C10.9458 0.274805 10.2708 0 9.5625 0H2.66667ZM5 10.5C4.44583 10.5 4 10.9389 4 11.4844C4 12.0299 4.44583 12.4688 5 12.4688H11C11.5542 12.4688 12 12.0299 12 11.4844C12 10.9389 11.5542 10.5 11 10.5H5ZM5 14.4375C4.44583 14.4375 4 14.8764 4 15.4219C4 15.9674 4.44583 16.4062 5 16.4062H11C11.5542 16.4062 12 15.9674 12 15.4219C12 14.8764 11.5542 14.4375 11 14.4375H5Z"
                fill="white"
                fill-opacity="0.45"
              />
            </svg>
            <div className="text-start">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF73]">
                Multas Aplicadas
              </h1>
              <p className="text-[.8vw] font-[500] text-[#FFFFFFD9]">
                {isLoadingStats ? "Carregando..." : 
                  officerStats.fines_applied && officerStats.fines_applied > 0
                    ? `${officerStats.fines_applied} Multas`
                    : "Nenhuma"}
              </p>
            </div>
          </div>
          <div className="section flex h-[3.38vw] w-[17.44vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] px-[.5vw]">
            <svg
              width="1.5vw"
              height="1.5vw"
              viewBox="0 0 16 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M2.66667 19.0312C2.3 19.0312 2 18.7359 2 18.375V2.625C2 2.26406 2.3 1.96875 2.66667 1.96875H9.33333V5.25C9.33333 5.97598 9.92917 6.5625 10.6667 6.5625H14V18.375C14 18.7359 13.7 19.0312 13.3333 19.0312H2.66667ZM2.66667 0C1.19583 0 0 1.17715 0 2.625V18.375C0 19.8229 1.19583 21 2.66667 21H13.3333C14.8042 21 16 19.8229 16 18.375V6.33691C16 5.63965 15.7208 4.97109 15.2208 4.47891L11.4458 0.766992C10.9458 0.274805 10.2708 0 9.5625 0H2.66667ZM5 10.5C4.44583 10.5 4 10.9389 4 11.4844C4 12.0299 4.44583 12.4688 5 12.4688H11C11.5542 12.4688 12 12.0299 12 11.4844C12 10.9389 11.5542 10.5 11 10.5H5ZM5 14.4375C4.44583 14.4375 4 14.8764 4 15.4219C4 15.9674 4.44583 16.4062 5 16.4062H11C11.5542 16.4062 12 15.9674 12 15.4219C12 14.8764 11.5542 14.4375 11 14.4375H5Z"
                fill="white"
                fill-opacity="0.45"
              />
            </svg>
            <div className="text-start">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF73]">
                Total em Multas Aplicadas
              </h1>
              <p className="text-[.8vw] font-[500] text-[#FFFFFFD9]">
                {isLoadingStats ? "Carregando..." : 
                  officerStats.total_fines_value && officerStats.total_fines_value > 0
                    ? `$ ${officerStats.total_fines_value.toLocaleString()}`
                    : "Nenhum valor"}
              </p>
            </div>
          </div>
          <div className="section flex h-[3.38vw] w-[17.44vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] px-[.5vw]">
            <svg
              width="1.5vw"
              height="1.5vw"
              viewBox="0 0 16 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M2.66667 19.0312C2.3 19.0312 2 18.7359 2 18.375V2.625C2 2.26406 2.3 1.96875 2.66667 1.96875H9.33333V5.25C9.33333 5.97598 9.92917 6.5625 10.6667 6.5625H14V18.375C14 18.7359 13.7 19.0312 13.3333 19.0312H2.66667ZM2.66667 0C1.19583 0 0 1.17715 0 2.625V18.375C0 19.8229 1.19583 21 2.66667 21H13.3333C14.8042 21 16 19.8229 16 18.375V6.33691C16 5.63965 15.7208 4.97109 15.2208 4.47891L11.4458 0.766992C10.9458 0.274805 10.2708 0 9.5625 0H2.66667ZM5 10.5C4.44583 10.5 4 10.9389 4 11.4844C4 12.0299 4.44583 12.4688 5 12.4688H11C11.5542 12.4688 12 12.0299 12 11.4844C12 10.9389 11.5542 10.5 11 10.5H5ZM5 14.4375C4.44583 14.4375 4 14.8764 4 15.4219C4 15.9674 4.44583 16.4062 5 16.4062H11C11.5542 16.4062 12 15.9674 12 15.4219C12 14.8764 11.5542 14.4375 11 14.4375H5Z"
                fill="white"
                fill-opacity="0.45"
              />
            </svg>
            <div className="text-start">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF73]">
                Tempo total trabalhando
              </h1>
              <p className="text-[.8vw] font-[500] text-[#FFFFFFD9]">
                {isLoadingStats ? "Carregando..." : 
                  officerStats.total_working_hours && officerStats.total_working_hours > 0
                    ? `${officerStats.total_working_hours} Horas`
                    : "Nenhuma hora"}
              </p>
            </div>
          </div>
          <div className="section flex h-[3.38vw] w-[17.44vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] px-[.5vw]">
            <svg
              width="1.5vw"
              height="1.5vw"
              viewBox="0 0 16 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M2.66667 19.0312C2.3 19.0312 2 18.7359 2 18.375V2.625C2 2.26406 2.3 1.96875 2.66667 1.96875H9.33333V5.25C9.33333 5.97598 9.92917 6.5625 10.6667 6.5625H14V18.375C14 18.7359 13.7 19.0312 13.3333 19.0312H2.66667ZM2.66667 0C1.19583 0 0 1.17715 0 2.625V18.375C0 19.8229 1.19583 21 2.66667 21H13.3333C14.8042 21 16 19.8229 16 18.375V6.33691C16 5.63965 15.7208 4.97109 15.2208 4.47891L11.4458 0.766992C10.9458 0.274805 10.2708 0 9.5625 0H2.66667ZM5 10.5C4.44583 10.5 4 10.9389 4 11.4844C4 12.0299 4.44583 12.4688 5 12.4688H11C11.5542 12.4688 12 12.0299 12 11.4844C12 10.9389 11.5542 10.5 11 10.5H5ZM5 14.4375C4.44583 14.4375 4 14.8764 4 15.4219C4 15.9674 4.44583 16.4062 5 16.4062H11C11.5542 16.4062 12 15.9674 12 15.4219C12 14.8764 11.5542 14.4375 11 14.4375H5Z"
                fill="white"
                fill-opacity="0.45"
              />
            </svg>
            <div className="text-start">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF73]">
                Veículos Apreendidos
              </h1>
              <p className="text-[.8vw] font-[500] text-[#FFFFFFD9]">
                {isLoadingStats ? "Carregando..." : 
                  officerStats.vehicles_seized && officerStats.vehicles_seized > 0
                    ? `${officerStats.vehicles_seized} Veículos`
                    : "Nenhum"}
              </p>
            </div>
          </div>
          <div className="section flex h-[3.38vw] w-[17.44vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] px-[.5vw]">
            <svg
              width="1.5vw"
              height="1.5vw"
              viewBox="0 0 16 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M2.66667 19.0312C2.3 19.0312 2 18.7359 2 18.375V2.625C2 2.26406 2.3 1.96875 2.66667 1.96875H9.33333V5.25C9.33333 5.97598 9.92917 6.5625 10.6667 6.5625H14V18.375C14 18.7359 13.7 19.0312 13.3333 19.0312H2.66667ZM2.66667 0C1.19583 0 0 1.17715 0 2.625V18.375C0 19.8229 1.19583 21 2.66667 21H13.3333C14.8042 21 16 19.8229 16 18.375V6.33691C16 5.63965 15.7208 4.97109 15.2208 4.47891L11.4458 0.766992C10.9458 0.274805 10.2708 0 9.5625 0H2.66667ZM5 10.5C4.44583 10.5 4 10.9389 4 11.4844C4 12.0299 4.44583 12.4688 5 12.4688H11C11.5542 12.4688 12 12.0299 12 11.4844C12 10.9389 11.5542 10.5 11 10.5H5ZM5 14.4375C4.44583 14.4375 4 14.8764 4 15.4219C4 15.9674 4.44583 16.4062 5 16.4062H11C11.5542 16.4062 12 15.9674 12 15.4219C12 14.8764 11.5542 14.4375 11 14.4375H5Z"
                fill="white"
                fill-opacity="0.45"
              />
            </svg>
            <div className="text-start">
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFF73]">
                Boletins Registrados
              </h1>
              <p className="text-[.8vw] font-[500] text-[#FFFFFFD9]">
                {isLoadingStats ? "Carregando..." : 
                  officerStats.reports_registered && officerStats.reports_registered > 0
                    ? `${officerStats.reports_registered} Boletins`
                    : "Nenhum"}
              </p>
            </div>
          </div>
        </div>
      </div>
      <button
        onClick={() => navigate("/panel/members")}
        className="text-[.8vw] text-white/80 hover:text-white"
      >
        Voltar
      </button>
    </div>
  );
}
