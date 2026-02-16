import { useBOInfo } from "@/stores/useBOInfo";
import { IOccurrence } from "@/types";
import { Icon } from "../../Navigation";

interface BOInfoModalProps {
  boData: IOccurrence | null;
}

export default function BOInfoModal({ boData }: BOInfoModalProps) {
  const { closeModal } = useBOInfo();

  if (!boData) return null;

  const handleClose = () => {
    closeModal();
  };

  return (
    <div className="bg-close absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.5vw]">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="text-[.8vw] font-[700] text-white">
            Informações do B.O.
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          {/* Tipo e Data */}
          <div className="grid grid-cols-2 gap-[.5vw]">
            <div>
              <p className="text-[.8vw] font-[500] text-[#FFFFFF80] mb-[.3vw]">
                Tipo
              </p>
              <div className="flex h-[2.5vw] w-full items-center gap-[.8vw] rounded-[.5vw] border border-[#FFFFFF08] bg-section px-[1vw]">
                <p className="text-[.8vw] font-[500] text-white">
                  {boData.type || "B.O."}
                </p>
              </div>
            </div>
            <div>
              <p className="text-[.8vw] font-[500] text-[#FFFFFF80] mb-[.3vw]">
                Data
              </p>
              <div className="flex h-[2.5vw] w-full items-center gap-[.8vw] rounded-[.5vw] border border-[#FFFFFF08] bg-section px-[1vw]">
                <p className="text-[.8vw] font-[500] text-white">
                  {boData.date}
                </p>
              </div>
            </div>
          </div>

          {/* Policial */}
          <div>
            <p className="text-[.8vw] font-[500] text-[#FFFFFF80] mb-[.3vw]">
              Policial
            </p>
            <div className="flex h-[2.5vw] w-full items-center gap-[.8vw] rounded-[.5vw] border border-[#FFFFFF08] bg-section px-[1vw]">
              <div className="bg-tag flex h-[1.4vw] w-fit items-center rounded-[.2vw] border border-[#FFFFFF0D] px-[.5vw]">
                <h1 className="text-[.8vw] font-[700] text-white">
                  #{'officerId' in boData ? (boData as any).officerId : 'N/A'}
                </h1>
              </div>
              <h1 className="text-[.8vw] font-[500] text-[#FFFFFFCC]">
                {boData.officerName || 'N/A'}
              </h1>
            </div>
          </div>

          {/* Descrição */}
          <div>
            <p className="text-[.8vw] font-[500] text-[#FFFFFF80] mb-[.3vw]">
              Descrição
            </p>
            <div className="flex h-[8vw] w-full flex-col rounded-[.5vw] border border-[#FFFFFF08] bg-section">
              <div className="flex-1 overflow-y-auto p-[1vw] scrollbar-hide">
                <p className="text-[.8vw] font-[500] text-[#FFFFFFCC] leading-relaxed break-words whitespace-pre-wrap">
                  {boData.description}
                </p>
              </div>
              <div className="px-[1vw] pb-[.5vw] text-right text-[.7vw] text-[#FFFFFF80] border-t border-[#FFFFFF08]">
                {boData.description.length} / 500
              </div>
            </div>
          </div>

          {/* Botões */}
          <div className="flex w-full items-center justify-center gap-[.5vw]">
            <button
              onClick={handleClose}
              className="h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] font-[700] text-[#FFFFFF80]"
            >
              Fechar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
