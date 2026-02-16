import { useState, useEffect } from "react";
import { Icon } from "../../Navigation";
import { useNavigate } from "react-router-dom";
import { Post } from "@/hooks/post";
import { useSuspectSearch } from "@/stores/useSuspectSearch";
import { useSelectOccurrence } from "@/stores/useOccurrence";

interface Suspect {
  id?: number;
  name: string;
  passport?: string;
  photo?: string;
}

export function SuspectSearchModal() {
  const [search, setSearch] = useState("");
  const [suspects, setSuspects] = useState<Suspect[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const { selectedSuspect, setSelectedSuspect } = useSuspectSearch();
  const { current: selectedOccurrence, set: setSelectedOccurrence } = useSelectOccurrence();
  const navigate = useNavigate();

  // Limpar seleção quando abrir o modal
  useEffect(() => {
    setSelectedSuspect(null);
  }, []);

  // Buscar automaticamente quando o search muda
  useEffect(() => {
    if (search.length > 0) {
      handleSearch();
    } else {
      setSuspects([]);
    }
  }, [search]);

  const handleSearch = async () => {
    if (search.length < 1) {
      setSuspects([]);
      return;
    }
    
    
    setIsLoading(true);
    try {
      // Usar a mesma abordagem do sistema de busca principal - buscar todos os jogadores e filtrar
      const allPlayers = await Post.create("getPlayers") as any;
      
              if (allPlayers && Array.isArray(allPlayers)) {
                // Filtrar os jogadores localmente
                const filteredPlayers = allPlayers.filter((player: any) => {
                  const playerName = (player.name || "").toLowerCase();
                  const playerId = (player.passport || "").toString();
                  const searchLower = search.toLowerCase();

                  return playerName.includes(searchLower) || playerId.includes(searchLower);
                });

                setSuspects(filteredPlayers);
      } else {
        setSuspects([]);
      }
    } catch (error) {
      setSuspects([]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSelectSuspect = (suspect: Suspect) => {
    setSelectedSuspect(suspect);
  };

  const handleConfirm = () => {
    if (selectedSuspect) {
      
      // Adicionar suspeito selecionado à ocorrência (usar passport como id)
      const suspectData = {
        id: Number(selectedSuspect.passport || selectedSuspect.id || 0),
        name: selectedSuspect.name
      };
      
      const updatedSuspects = [...selectedOccurrence.suspects, suspectData];
      
      setSelectedOccurrence({
        ...selectedOccurrence,
        suspects: updatedSuspects
      });
      
      // Limpar seleção e fechar modal
      setSelectedSuspect(null);
      navigate(-1);
    }
  };

  return (
    <div className="bg-close absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.5vw]">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="text-[.8vw] font-[700] text-white">
            Buscar Suspeito
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <p className="text-[.8vw] font-[500] text-[#FFFFFF80]">
            Buscar Suspeito
          </p>
          <div className="flex h-[2.5vw] w-full items-center gap-[.8vw] rounded-[.5vw] border border-[#FFFFFF08] bg-section px-[1vw]">
            <svg
              width=".8vw"
              height=".8vw"
              viewBox="0 0 16 16"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fillRule="evenodd"
                clipRule="evenodd"
                d="M7.11678 1.99363e-08C5.98188 0.00010002 4.86338 0.2716 3.85478 0.7918C2.84608 1.3121 1.97638 2.066 1.31838 2.9907C0.66038 3.9154 0.23298 4.984 0.0719799 6.1074C-0.0890201 7.2308 0.0209807 8.3765 0.392781 9.4487C0.764581 10.521 1.38738 11.4888 2.20928 12.2715C3.03128 13.0541 4.02848 13.6288 5.11768 13.9476C6.20688 14.2665 7.35658 14.3203 8.47078 14.1045C9.58508 13.8887 10.6316 13.4096 11.523 12.7071L14.5809 15.765C14.7389 15.9175 14.9504 16.0019 15.1699 16C15.3895 15.9981 15.5995 15.91 15.7547 15.7548C15.91 15.5995 15.9981 15.3895 16 15.17C16.0019 14.9504 15.9175 14.7389 15.7649 14.581L12.707 11.5231C13.5343 10.4736 14.0494 9.2125 14.1933 7.8839C14.3373 6.5554 14.1043 5.2131 13.521 4.0108C12.9378 2.8085 12.0278 1.7947 10.8952 1.0854C9.76258 0.376 8.45318 -9.99801e-05 7.11678 1.99363e-08ZM1.67408 7.1172C1.67408 5.6737 2.24748 4.2894 3.26818 3.2687C4.28888 2.248 5.67328 1.6746 7.11678 1.6746C8.56028 1.6746 9.94468 2.248 10.9654 3.2687C11.9862 4.2894 12.5596 5.6737 12.5596 7.1172C12.5596 8.5606 11.9862 9.945 10.9654 10.9656C9.94468 11.9863 8.56028 12.5597 7.11678 12.5597C5.67328 12.5597 4.28888 11.9863 3.26818 10.9656C2.24748 9.945 1.67408 8.5606 1.67408 7.1172Z"
                fill="white"
                fillOpacity="0.5"
              />
            </svg>
            <input
              type="text"
              value={search}
                      onChange={(e) => {
                        setSearch(e.target.value);
                      }}
              className="h-full w-full bg-transparent text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
              placeholder="Buscar por nome ou ID"
            />
          </div>
          
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
          
          <div className="flex h-[14vw] w-full flex-col gap-[.3vw] overflow-auto">
            {suspects.length > 0 ? (
              suspects.map((suspect) => {
                const isSelected = selectedSuspect && (
                  (selectedSuspect.id && selectedSuspect.id === suspect.id) ||
                  (selectedSuspect.passport && selectedSuspect.passport === suspect.passport)
                );
                

                return (
                  <button
                    key={suspect.passport || suspect.id}
                    onClick={() => handleSelectSuspect(suspect)}
                    className={`relative flex h-[3vw] w-full flex-none items-center gap-[.8vw] rounded-[.3vw] border p-[.5vw] ${
                      isSelected 
                        ? "bg-section border border-[#79FF9250] hover:bg-white/5" 
                        : "bg-section border border-[#FFFFFF08] hover:bg-white/5 hover:border-[#79FF921A]"
                    }`}
                  >
                    <div className="relative flex h-[2.5vw] w-[2.5vw] items-center justify-center rounded-[.2vw]">
                      <img
                        src={
                          suspect.photo
                            ? suspect.photo
                            : "./default-profile.png"
                        }
                        className="h-full w-full rounded-[.2vw]"
                        alt=""
                      />
                    </div>
                    <div className="flex items-center gap-[1vw]">
                      <div className="flex flex-col gap-[.1vw]">
                        <p className="text-[.6vw] text-[#FFFFFF80]">
                          Nome
                        </p>
                        <h1 className="text-[.8vw] font-[500] text-white">
                          {suspect.name}
                        </h1>
                      </div>
                      <div className="flex flex-col gap-[.1vw]">
                        <p className="text-[.6vw] text-[#FFFFFF80]">
                          Passaporte
                        </p>
                        <h1 className="text-[.8vw] font-[500] text-white">
                          {suspect.passport}
                        </h1>
                      </div>
                    </div>
                    {isSelected && (
                      <svg
                        width=".78vw"
                        height=".57vw"
                        className="absolute right-[.7vw]"
                        viewBox="0 0 15 11"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          d="M5.09467 10.784L0.219661 5.98988C-0.0732203 5.70186 -0.0732203 5.23487 0.219661 4.94682L1.2803 3.90377C1.57318 3.61572 2.04808 3.61572 2.34096 3.90377L5.625 7.13326L12.659 0.216014C12.9519 -0.0720048 13.4268 -0.0720048 13.7197 0.216014L14.7803 1.25907C15.0732 1.54709 15.0732 2.01408 14.7803 2.30213L6.15533 10.784C5.86242 11.072 5.38755 11.072 5.09467 10.784Z"
                          fill="#79FF92"
                        />
                      </svg>
                    )}
                  </button>
                );
              })
            ) : search && !isLoading ? (
              <div className="flex h-[4vw] w-full items-center justify-center">
                <p className="text-[.8vw] text-[#FFFFFF80]">
                  Nenhum resultado encontrado
                </p>
              </div>
            ) : null}
          </div>

          <div className="flex w-full items-center justify-between gap-[.5vw]">
            <button
              onClick={handleConfirm}
              disabled={!selectedSuspect}
              className="bg-tag h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF26] text-[.8vw] font-[700] text-white hover:scale-95 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {selectedSuspect ? `Selecionar ${selectedSuspect.name}` : 'Selecionar Suspeito'}
            </button>
            <button
              onClick={() => navigate(-1)}
              className="h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] font-[700] text-[#FFFFFF80]"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
