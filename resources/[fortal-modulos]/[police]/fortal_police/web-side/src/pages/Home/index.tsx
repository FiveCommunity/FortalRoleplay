import { compareDesc, format, parseISO } from "date-fns";
import { warnsMockup } from "@/mockUp";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Chart } from "./components/Chart";
import { ISelectedStatistics } from "@/types";
import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { useAnnounceFrame } from "@/stores/useHome";
import { usePermissions } from "@/providers/Permissions";
import { useDeleteAnnounce } from "@/stores/useDeleteAnnounce";

export const Home = () => {
  const { current: announce, set: setAnnounce } = useAnnounceFrame();
  const navigate = useNavigate();
  const location = useLocation();
  const { canPerformAction } = usePermissions();
  const { setDeleteData } = useDeleteAnnounce();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: { pathname: location.pathname, search: location.search } },
    });
  };

  const handleDeleteAnnounce = (announceId: string, announceTitle: string) => {
    const confirmDelete = (announceId: string) => {
      // Usar fetch diretamente para o endpoint do FiveM
      const resourceName = (window as any).GetParentResourceName ? (window as any).GetParentResourceName() : "nui-frame-app";
      
      fetch(`https://${resourceName}/deleteAnnounce`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ announceId })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          // Fechar o modal após sucesso
          navigate(-1);
        }
      })
      .catch(() => {
        // Erro silencioso
      });
    };

    setDeleteData(announceId, announceTitle, confirmDelete);
    navigate("/panel/delete-announce", {
      state: { 
        backgroundLocation: { pathname: location.pathname, search: location.search }
      },
    });
  };

  useEffect(() => {
    Post.create("getWarns", {}, warnsMockup).then((resp: any) => {
      setAnnounce(resp);
    });
  }, []);

  // Listener para atualização em tempo real - simplificado
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updateWarns') {
        if (Array.isArray(event.data.data)) {
          setAnnounce(event.data.data);
        }
      }
    };
    
    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [setAnnounce]);

  const [, setStatisticsFormatted] = useState<ISelectedStatistics[]>([]);
  const [selectedStatistics, setSelectedStatistics] =
    useState<ISelectedStatistics>();

  useEffect(() => {
    const getData = async () => {
      const statistics = await Post.create(
        "getStatistics",
        {},
        [], // Removido mockup
      );

      if (statistics && statistics.length > 0) {
        const statisticsFormatted = statistics.sort((a: any, b: any) =>
          compareDesc(parseISO(a.date), parseISO(b.date)),
        );
        setStatisticsFormatted(statisticsFormatted);

        if (statisticsFormatted.length)
          return setSelectedStatistics(statisticsFormatted[0]);
      }
    };
    getData();
  }, []);

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.home className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Área Inicial
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <div className="h-[13vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.3vw] w-full items-center justify-between bg-[#FFFFFF05] px-[1vw]">
            <h1 className="text-[.8vw] text-white">Quadro de avisos</h1>
            {canPerformAction('canAnnounce') && (
              <button onClick={() => openModal("/panel/modal")}>
                <Icon.add className="w-[.8vw] text-[#59585F] hover:text-white" />
              </button>
            )}
          </div>
          <div className="flex h-[calc(100%-2.3vw)] w-full p-[.5vw]">
            <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
              {Array.isArray(announce) ? announce.map((data) => {
              
                const parsedDate = parseISO(data.createdAt);
               
                const formattedDate = format(parsedDate, "dd/LL/uuuu");

                
                return (
                <div key={data.id} className="w-full flex-none border-b border-solid border-[#FFFFFF0D] pb-[.5vw] group relative">
                  <div className="flex items-start justify-between w-full">
                    <div className="flex-1 pr-2">
                      <p className="text-[.7vw] text-[#FFFFFF8C]">
                        {formattedDate}
                      </p>
                      <h1 className="text-[.8vw] font-semibold text-white">
                        {data.title}
                      </h1>
                      <p 
                        className="text-[.7vw] text-[#FFFFFFBF] break-words"
                        title={data.description}
                      >
                        {data.description}
                      </p>
                    </div>
                    {canPerformAction('canDeleteAnnounce') && (
                      <button
                        onClick={() => handleDeleteAnnounce(data.id, data.title)}
                        className="opacity-100 group-hover:opacity-100 transition-opacity duration-200 p-1 rounded hover:bg-red-500/20 flex-shrink-0"
                        title="Deletar anúncio"
                      >
                        <svg
                          width="1.2vw"
                          height="1.2vw"
                          viewBox="0 0 24 24"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                          className="text-red-400 hover:text-red-300"
                        >
                          <path
                            d="M3 6H5H21M8 6V4C8 3.46957 8.21071 2.96086 8.58579 2.58579C8.96086 2.21071 9.46957 2 10 2H14C14.5304 2 15.0391 2.21071 15.4142 2.58579C15.7893 2.96086 16 3.46957 16 4V6M19 6V20C19 20.5304 18.7893 21.0391 18.4142 21.4142C18.0391 21.7893 17.5304 22 17 22H7C6.46957 22 5.96086 21.7893 5.58579 21.4142C5.21071 21.0391 5 20.5304 5 20V6H19Z"
                            stroke="currentColor"
                            strokeWidth="2"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                          />
                          <path
                            d="M10 11V17"
                            stroke="currentColor"
                            strokeWidth="2"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                          />
                          <path
                            d="M14 11V17"
                            stroke="currentColor"
                            strokeWidth="2"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                          />
                        </svg>
                      </button>
                    )}
                  </div>
                </div>
                );
              }) : (
                <div className="text-[.8vw] text-[#FFFFFF8C]">
                  Carregando avisos...
                </div>
              )}
            </div>
          </div>
        </div>
        <div className="mt-[.5vw] flex h-[calc(100%-13.5vw)] w-full flex-col gap-[.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.3vw] w-full items-center justify-between bg-[#FFFFFF05] px-[1vw]">
            <h1 className="text-[.8vw] text-white">Gráfico de Estatísticas</h1>
            <button className="h-[1.5vw] w-[2.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section text-[.7vw] leading-none text-[#FFFFFFA6]">
              MÊS
            </button>
          </div>
          <Chart selectedStatistics={selectedStatistics || { date: '', data: [] }} />
        </div>
      </div>
    </div>
  );
};
