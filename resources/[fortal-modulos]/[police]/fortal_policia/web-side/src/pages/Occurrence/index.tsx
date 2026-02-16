import {
  useDescription,
  useOccurrence,
  useSelectOccurrence,
} from "@/stores/useOccurrence";
import { useBOInfo } from "@/stores/useBOInfo";
import { IOccurrence } from "@/types";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import BOInfoModal from "@/components/_components/Modals/BOInfoModal";

export function Occurrence() {
  const [modal, setModal] = useState(false);
  const { current: occurrences, set: setOcurrences } = useOccurrence();
  const { current: selected, set: setSelected } = useSelectOccurrence();
  const [suspect, setSuspect] = useState(false);
  const { current: value, set: setValue } = useDescription();
  const { isOpen: isBOInfoOpen, boData, openModal: openBOInfoModal } = useBOInfo();
  const navigate = useNavigate();
  const location = useLocation();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: { pathname: location.pathname, search: location.search } },
    });
  };

  const handleBOInfoClick = (boData: IOccurrence) => {
    openBOInfoModal(boData);
  };

  const handleStatusToggle = (id: string, currentStatus: string) => {
    const newStatus = currentStatus === "Aberto" ? "Arquivado" : "Aberto";
    
    Post.create("updateOccurrenceStatus", { 
      id: id, 
      status: newStatus 
    }).then((response: any) => {
      if (response.success) {
        // Atualizar o status localmente
        const currentOccurrences = occurrences;
        const updatedOccurrences = currentOccurrences.map((occurrence: IOccurrence) => 
          String(occurrence.id) === id 
            ? { ...occurrence, status: newStatus }
            : occurrence
        );
        setOcurrences(updatedOccurrences);
      } else {
        console.error('Erro ao atualizar status:', response.message);
      }
    }).catch((error) => {
      console.error('Erro ao atualizar status:', error);
    });
  };

  useEffect(() => {


    Post.create("getOccurrences").then((resp: any) => {
      setOcurrences(resp);
    });

    // Listeners para atualização em tempo real
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updateOccurrences') {
     
        setOcurrences(event.data.data);
      }
    };

    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [setOcurrences]);


  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.list className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Boletim de Ocorrência
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        {!modal ? (
          <div className="h-full w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between border-b border-solid border-[#FFFFFF14] bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">
                Lista de Boletins de Ocorrência
              </h1>
              <button onClick={() => setModal(!modal)}>
                <Icon.add className="size-[.8vw] text-[#59585F] hover:text-white" />
              </button>
            </div>
            <div className="flex h-[calc(100%-2.3vw)] w-full flex-col overflow-auto">
              <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF14] bg-[#FFFFFF08] px-[.5vw]">
                <h1 className="w-[5vw] text-[.8vw] text-[#FFFFFFA6]">ID</h1>
                <h1 className="w-[8vw] text-[.8vw] text-[#FFFFFFA6]">Data</h1>
                <h1 className="w-[12vw] text-[.8vw] text-[#FFFFFFA6]">
                  Policial
                </h1>
                <h1 className="w-[15vw] text-[.8vw] text-[#FFFFFFA6]">
                  Descrição
                </h1>
                <h1 className="w-[8vw] text-[.8vw] text-[#FFFFFFA6]">Status</h1>
                <h1 className="text-end text-[.8vw] text-[#FFFFFFA6]">Ações</h1>
              </div>
              {occurrences.map((data) => (
                <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF14] bg-[#FFFFFF08] px-[.5vw]">
                  <h1 className="w-[5vw] text-[.8vw] text-[#FFFFFFA6]">
                    #{data.id}
                  </h1>
                  <h1 className="w-[8vw] text-[.8vw] text-[#FFFFFFA6]">
                    {data.date}
                  </h1>
                  <div className="flex w-[12vw] items-center gap-[.3vw]">
                    <div className="rounded-[.2vw] border border-[#FFFFFF12] bg-[#FFFFFF0D] px-[.3vw] py-[.1vw]">
                      <h1 className="text-[.7vw] text-white">
                        #{'officerId' in data ? (data as any).officerId : 'N/A'}
                      </h1>
                    </div>
                    <h1 className="text-[.8vw] text-[#FFFFFFA6]">
                      {data.officerName || 'N/A'}
                    </h1>
                  </div>
                  <h1 
                    onClick={() => handleBOInfoClick(data)}
                    className="w-[15vw] cursor-pointer text-[.8vw] text-[#FFFFFFA6] transition-colors hover:text-white"
                  >
                    {data.description.length > 25
                      ? `${data.description.slice(0, 25)}...`
                      : data.description}
                  </h1>
                  <h1 
                    onClick={() => handleStatusToggle(String(data.id), data.status)}
                    className="flex w-[8vw] cursor-pointer items-center gap-[.5vw] text-[.8vw] text-[#FFFFFFA6] rounded-[.2vw] px-[.3vw] py-[.2vw]"
                  >
                    <div
                      className={`h-[.3vw] w-[.3vw] rounded-full ${data.status === "Aberto" ? "bg-[#7AFF73] shadow-[0_0_15px_#7AFF7380]" : "bg-[#FF7373] shadow-[0_0_15px_#FF737380]"}`}
                    />
                    {data.status || "N/A"}
                  </h1>
                  <button
                    onClick={() =>
                      Post.create("deleteOccurrence", { id: data.id })
                    }
                  >
                    <h1 className="text-end text-[.8vw] text-[#DE5757C9] hover:text-[#DE5757C9]/50">
                      Excluir
                    </h1>
                  </button>
                </div>
              ))}
            </div>
          </div>
        ) : (
          <div className="flex h-full w-full flex-col overflow-auto">
            <h1 className="text-[.8vw] text-[#FFFFFF4D]">
              Você está realizando um boletim de ocorrência
            </h1>
            <button
              onClick={() => setModal(!modal)}
              className="mt-[.5vw] flex h-[2.5vw] w-full flex-none items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF0D] bg-buttonSelected px-[1vw] text-[.8vw] text-white"
            >
              <svg
                width=".9vw"
                height=".9vw"
                viewBox="0 0 18 18"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M1.92857 15.4286C1.92857 15.7821 2.21786 16.0714 2.57143 16.0714H15.4286C15.7821 16.0714 16.0714 15.7821 16.0714 15.4286V2.57143C16.0714 2.21786 15.7821 1.92857 15.4286 1.92857H2.57143C2.21786 1.92857 1.92857 2.21786 1.92857 2.57143V15.4286ZM2.57143 18C1.15313 18 0 16.8469 0 15.4286V2.57143C0 1.15313 1.15313 0 2.57143 0H15.4286C16.8469 0 18 1.15313 18 2.57143V15.4286C18 16.8469 16.8469 18 15.4286 18H2.57143ZM5.14286 9C5.14286 8.7308 5.25536 8.47768 5.45223 8.29286L9.95223 4.11429C10.2335 3.85312 10.6433 3.78482 10.9929 3.9375C11.3424 4.09018 11.5714 4.43973 11.5714 4.82143V13.1786C11.5714 13.5603 11.3424 13.9098 10.9929 14.0625C10.6433 14.2152 10.2335 14.1469 9.95223 13.8857L5.45223 9.70714C5.25536 9.52634 5.14286 9.2692 5.14286 9Z"
                  fill="white"
                />
                <path
                  d="M1.92857 15.4286C1.92857 15.7821 2.21786 16.0714 2.57143 16.0714H15.4286C15.7821 16.0714 16.0714 15.7821 16.0714 15.4286V2.57143C16.0714 2.21786 15.7821 1.92857 15.4286 1.92857H2.57143C2.21786 1.92857 1.92857 2.21786 1.92857 2.57143V15.4286ZM2.57143 18C1.15313 18 0 16.8469 0 15.4286V2.57143C0 1.15313 1.15313 0 2.57143 0H15.4286C16.8469 0 18 1.15313 18 2.57143V15.4286C18 16.8469 16.8469 18 15.4286 18H2.57143ZM5.14286 9C5.14286 8.7308 5.25536 8.47768 5.45223 8.29286L9.95223 4.11429C10.2335 3.85312 10.6433 3.78482 10.9929 3.9375C11.3424 4.09018 11.5714 4.43973 11.5714 4.82143V13.1786C11.5714 13.5603 11.3424 13.9098 10.9929 14.0625C10.6433 14.2152 10.2335 14.1469 9.95223 13.8857L5.45223 9.70714C5.25536 9.52634 5.14286 9.2692 5.14286 9Z"
                  fill="url(#paint0_radial_857_3)"
                  fill-opacity="0.25"
                />
                <path
                  d="M2.57129 0.5H15.4287C16.5708 0.500076 17.4999 1.42924 17.5 2.57129V15.4287C17.4999 16.5708 16.5708 17.4999 15.4287 17.5H2.57129C1.42924 17.4999 0.500076 16.5708 0.5 15.4287V2.57129C0.500076 1.42924 1.15313 0.500076 2.57129 0.5ZM2.57129 1.42871C1.94169 1.42879 1.42879 1.94169 1.42871 2.57129V15.4287C1.42879 16.0583 1.94169 16.5712 2.57129 16.5713H15.4287C16.0583 16.5712 16.5712 16.0583 16.5713 15.4287V2.57129C16.5712 1.94169 16.0583 1.42879 15.4287 1.42871H2.57129ZM10.292 4.48047C10.4269 4.35518 10.6251 4.32219 10.793 4.39551C10.9604 4.46871 11.0712 4.63861 11.0713 4.82129V13.1787C11.0712 13.3614 10.9604 13.5313 10.793 13.6045C10.6251 13.6778 10.4269 13.6448 10.292 13.5195L5.79199 9.34082L5.79004 9.33887C5.69724 9.25353 5.64258 9.13023 5.64258 9C5.64258 8.87283 5.69581 8.75027 5.79492 8.65723L5.79395 8.65625L10.292 4.48047Z"
                  stroke="white"
                  stroke-opacity="0.05"
                />
                <defs>
                  <radialGradient
                    id="paint0_radial_857_3"
                    cx="0"
                    cy="0"
                    r="1"
                    gradientUnits="userSpaceOnUse"
                    gradientTransform="translate(8.97179 13.8) scale(10.8056 17.1847)"
                  >
                    <stop stop-color="white" />
                    <stop offset="1" stop-color="white" stop-opacity="0" />
                  </radialGradient>
                </defs>
              </svg>
              Voltar
            </button>
            <div className="mt-[.5vw] flex w-full flex-col gap-[.5vw] overflow-auto">
              <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
                <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
                  <h1 className="text-[.8vw] text-white">
                    Adicionar Requerente
                  </h1>
                </div>

                <div className="flex w-full p-[.5vw]">
                  <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                    <div
                      onClick={() => {
                        setSuspect(!suspect);
                      }}
                      className="flex h-[2.3vw] cursor-pointer items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.8vw]"
                    >
                      <div className="flex items-center gap-[.5vw]">
                        <Icon.anex />
                        <h1 className="text-[.8vw] text-[#FFFFFF80]">
                          Anexar{" "}
                          <span className="text-[#FFFFFFD9]">Requerente</span>
                        </h1>
                      </div>
                      <Icon.arrowBotom />
                    </div>

                    {/* Mostrar requerentes selecionados */}
                    {selected.applicant.length > 0 && (
                      <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                        {selected.applicant.map((data) => (
                          <button
                            key={data.id}
                            onClick={() => {
                              const updatedApplicants = selected.applicant.filter(a => a.id !== data.id);
                              setSelected({
                                ...selected,
                                applicant: updatedApplicants
                              });
                            }}
                            className="hover:bg-sucess relative flex h-[2.3vw] w-fit flex-none items-center gap-[.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.4vw] hover:border-[#79FF921A] group"
                          >
                            <div className="bg-blue-500 flex h-[1.4vw] w-fit items-center rounded-[.2vw] px-[.5vw] z-10">
                              <h1 className="text-[.8vw] font-[700] capitalize text-white">
                                #{data.id}
                              </h1>
                            </div>
                            <h1 className="text-[.8vw] font-[500] text-[#FFFFFFCC] truncate z-10">
                              {data.name}
                            </h1>
                            <div className="absolute left-0 top-0 flex h-full w-full items-center justify-center rounded-[.3vw] bg-[#FF5858D9] opacity-0 group-hover:opacity-100 transition-opacity z-20">
                              <svg
                                width=".8vw"
                                height=".8vw"
                                viewBox="0 0 17 17"
                                fill="none"
                                xmlns="http://www.w3.org/2000/svg"
                              >
                                <path
                                  d="M16.4969 2.90325C17.1606 2.2395 17.1606 1.16156 16.4969 0.497813C15.8331 -0.165938 14.7552 -0.165938 14.0914 0.497813L8.5 6.09456L2.90325 0.503123C2.2395 -0.160628 1.16156 -0.160628 0.497813 0.503123C-0.165938 1.16687 -0.165938 2.24481 0.497813 2.90856L6.09456 8.5L0.503124 14.0967C-0.160628 14.7605 -0.160628 15.8384 0.503124 16.5022C1.16687 17.1659 2.24481 17.1659 2.90856 16.5022L8.5 10.9054L14.0968 16.4969C14.7605 17.1606 15.8384 17.1606 16.5022 16.4969C17.1659 15.8331 17.1659 14.7552 16.5022 14.0914L10.9054 8.5L16.4969 2.90325Z"
                                  fill="white"
                                />
                              </svg>
                            </div>
                          </button>
                        ))}
                      </div>
                    )}
                  </div>
                </div>
              </div>

              <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
                <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
                  <h1 className="text-[.8vw] text-white">
                    Adicionar Suspeitos
                  </h1>
                </div>

                <div className="flex w-full p-[.5vw]">
                  <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                    <div
                      onClick={() => openModal("/panel/occurrence/suspect-search")}
                      className="flex h-[2.3vw] cursor-pointer items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.8vw] hover:bg-white/5"
                    >
                      <div className="flex items-center gap-[.5vw]">
                        <Icon.anex />
                        <h1 className="text-[.8vw] text-[#FFFFFF80]">
                          Anexar{" "}
                          <span className="text-[#FFFFFFD9]">Suspeitos</span>
                        </h1>
                      </div>
                      <Icon.arrowBotom />
                    </div>

                    {/* Mostrar suspeitos selecionados */}
                    {selected.suspects.length > 0 && (
                      <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                        {selected.suspects.map((suspect) => (
                          <button
                            key={suspect.id}
                            onClick={() => {
                              const updatedSuspects = selected.suspects.filter(s => s.id !== suspect.id);
                              setSelected({
                                ...selected,
                                suspects: updatedSuspects
                              });
                            }}
                            className="hover:bg-sucess relative flex h-[2.3vw] w-fit flex-none items-center gap-[.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.4vw] hover:border-[#79FF921A] group"
                          >
                            <div className="bg-blue-500 flex h-[1.4vw] w-fit items-center rounded-[.2vw] px-[.5vw] z-10">
                              <h1 className="text-[.8vw] font-[700] capitalize text-white">
                                #{suspect.id}
                              </h1>
                            </div>
                            <h1 className="text-[.8vw] font-[500] text-[#FFFFFFCC] truncate z-10">
                              {suspect.name}
                            </h1>
                            <div className="absolute left-0 top-0 flex h-full w-full items-center justify-center rounded-[.3vw] bg-[#FF5858D9] opacity-0 group-hover:opacity-100 transition-opacity z-20">
                              <svg
                                width=".8vw"
                                height=".8vw"
                                viewBox="0 0 17 17"
                                fill="none"
                                xmlns="http://www.w3.org/2000/svg"
                              >
                                <path
                                  d="M16.4969 2.90325C17.1606 2.2395 17.1606 1.16156 16.4969 0.497813C15.8331 -0.165938 14.7552 -0.165938 14.0914 0.497813L8.5 6.09456L2.90325 0.503123C2.2395 -0.160628 1.16156 -0.160628 0.497813 0.503123C-0.165938 1.16687 -0.165938 2.24481 0.497813 2.90856L6.09456 8.5L0.503124 14.0967C-0.160628 14.7605 -0.160628 15.8384 0.503124 16.5022C1.16687 17.1659 2.24481 17.1659 2.90856 16.5022L8.5 10.9054L14.0968 16.4969C14.7605 17.1606 15.8384 17.1606 16.5022 16.4969C17.1659 15.8331 17.1659 14.7552 16.5022 14.0914L10.9054 8.5L16.4969 2.90325Z"
                                  fill="white"
                                />
                              </svg>
                            </div>
                          </button>
                        ))}
                      </div>
                    )}
                  </div>
                </div>
              </div>

              <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
                <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
                  <h1 className="text-[.8vw] text-white">
                    Descrição do Boletim
                  </h1>
                </div>

                <div className="flex w-full p-[.5vw]">
                  <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                    <div className="relative">
                      <h1 className="absolute bottom-0 right-0 z-50 p-[1vw] text-[.8vw] text-[#FFFFFF59]">
                        <span
                          className={`${value.length >= 490 ? "text-red-500" : "text-[#FFFFFF80]"}`}
                        >
                          {value.length}
                        </span>{" "}
                        / 500
                      </h1>
                      <textarea
                        name=""
                        onChange={(e) => setValue(e.target.value)}
                        value={value}
                        maxLength={500}
                        placeholder="Descreva o boletim de ocorrência aqui..."
                        className="h-[10vw] w-full resize-none rounded-[.3vw] border border-[#FFFFFF08] bg-transparent bg-section p-[.5vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
                        id=""
                      ></textarea>
                    </div>
                  </div>
                </div>
              </div>
              <div className="flex w-full items-center gap-[.5vw]">
                <button
                  onClick={() => {
                    setSelected({ applicant: [], suspects: [] });
                    setValue("");
                  }}
                  className="h-[2.5vw] w-full rounded-[.5vw] border border-[#FFFFFF08] bg-section text-[#FFFFFFD9] hover:text-white"
                >
                  Resetar Dados
                </button>
                <button
                  onClick={() => openModal("/panel/occurrence/modal")}
                  className="h-[2.5vw] w-[8vw] rounded-[.4vw] bg-buttonSelected text-[.8vw] text-white"
                >
                  Criar Boletim
                </button>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Modal de Informações do B.O. */}
      {isBOInfoOpen && <BOInfoModal boData={boData} />}
    </div>
  );
}
