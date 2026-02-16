import { useEffect, useState } from "react";

import { Icon } from "../../Navigation";
import { Post } from "@/hooks/post";
import { useNavigate } from "react-router-dom";

interface ICharge {
  name: string;
  desc: string;
}

export function AddMember() {
  const navigate = useNavigate();
  const [idValue, setIdValue] = useState("");
  const [selected, setSelected] = useState(-1);
  const [isOpen, setIsOpen] = useState(false);
  const [charge, setCharge] = useState<ICharge[]>([]);

  const handleClose = () => {
    setIdValue("");
    setSelected(0);
    navigate(-1);
  };

  useEffect(() => {
    Post.create("getChargeContract").then((resp: any) => {
      setCharge(resp);
    }).catch((error) => {
      console.error("[DEBUG HIRE] Erro ao buscar cargos:", error);
    });
  }, []);

  const handleConfirm = () => {
    if (!idValue || selected < 0 || !charge[selected]) {
      return;
    }
    Post.create("fortal_police:hireMember", { id: idValue, rank: charge[selected].desc })
      .then(() => {
        // Fechar o modal após sucesso
        navigate("/panel/members");
      })
      .catch((error) => {
        // Em caso de erro, mostrar mensagem mas não fechar o modal
        console.error("[MODAL] Erro ao contratar membro:", error);
      });
  };

  return (
    <div className="bg-close absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.5vw]">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Convidar Membro para sua Corporação
          </h1>
        </div>
        <div className="w-full p-[1vw]">
          <h1 className="text-[.8vw] text-[#FFFFFF80]">ID do Convidado</h1>
          <input
            type="number"
            value={idValue}
            onChange={(e) => setIdValue(e.target.value)}
            className="mt-[.5vw] h-[2.5vw] w-full rounded-[.4vw] border border-[#DEE5FF59] bg-transparent bg-section px-[1vw] text-[.8vw] text-white placeholder:text-[#DEE5FF]"
            placeholder="Escreva o ID aqui..."
          />

          <h1 className="mt-[.5vw] text-[.8vw] text-[#FFFFFF80]">
            Patente Inicial
          </h1>

          <div
            className="mt-[.5vw] flex h-[3vw] w-full cursor-pointer items-center justify-between gap-[.5vw] rounded-[.5vw] border border-[#FFFFFF08] bg-section px-[1vw]"
            onClick={() => setIsOpen(!isOpen)}
          >
            <div className="flex items-center gap-[1vw]">
              <svg
                width="1vw"
                height="1.5vw"
                viewBox="0 0 21 26"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M9.50438 0.278009C10.1057 -0.0926696 10.893 -0.0926696 11.4943 0.278009L12.4675 0.87211C12.7955 1.07014 13.1782 1.16662 13.5663 1.14631L14.7308 1.0803C15.4524 1.03968 16.1303 1.40528 16.4529 2.00446L16.9777 2.97431C17.1526 3.29929 17.4369 3.55826 17.7813 3.72075L18.8365 4.21329C19.4816 4.51288 19.8752 5.14253 19.8314 5.8128L19.7604 6.89437C19.7385 7.25489 19.8424 7.61541 20.0556 7.915L20.7007 8.81885C21.0998 9.3774 21.0998 10.1086 20.7007 10.6672L20.0556 11.5761C19.8424 11.8808 19.7385 12.2362 19.7604 12.5967L19.8314 13.6783C19.8752 14.3486 19.4816 14.9782 18.8365 15.2778L17.7923 15.7653C17.4424 15.9277 17.1636 16.1918 16.9886 16.5117L16.4583 17.4917C16.1358 18.0909 15.4579 18.4565 14.7362 18.4159L13.5718 18.3499C13.1836 18.3295 12.7955 18.426 12.4729 18.6241L11.4998 19.2232C10.8985 19.5939 10.1112 19.5939 9.50985 19.2232L8.53126 18.6241C8.20325 18.426 7.82056 18.3295 7.43241 18.3499L6.26795 18.4159C5.54631 18.4565 4.86841 18.0909 4.54586 17.4917L4.02103 16.5218C3.84609 16.1969 3.56181 15.9379 3.21739 15.7754L2.16227 15.2829C1.51717 14.9833 1.12355 14.3536 1.16729 13.6834L1.23836 12.6018C1.26023 12.2413 1.15635 11.8808 0.943142 11.5812L0.30351 10.6722C-0.0955773 10.1137 -0.0955773 9.38248 0.30351 8.82393L0.943142 7.92008C1.15635 7.61541 1.26023 7.25997 1.23836 6.89944L1.16729 5.81787C1.12355 5.14761 1.51717 4.51796 2.16227 4.21837L3.20646 3.7309C3.55634 3.56334 3.84062 3.29929 4.01557 2.97431L4.54039 2.00446C4.86294 1.40528 5.54084 1.03968 6.26248 1.0803L7.42694 1.14631C7.81509 1.16662 8.20325 1.07014 8.5258 0.87211L9.50438 0.278009ZM14.8729 9.74808C14.8729 8.67071 14.4121 7.63747 13.5919 6.87565C12.7717 6.11384 11.6593 5.68585 10.4994 5.68585C9.33942 5.68585 8.22699 6.11384 7.40679 6.87565C6.58659 7.63747 6.12581 8.67071 6.12581 9.74808C6.12581 10.8255 6.58659 11.8587 7.40679 12.6205C8.22699 13.3823 9.33942 13.8103 10.4994 13.8103C11.6593 13.8103 12.7717 13.3823 13.5919 12.6205C14.4121 11.8587 14.8729 10.8255 14.8729 9.74808ZM0.073898 22.4324L2.43015 17.2277C2.44109 17.2327 2.44655 17.2378 2.45202 17.248L2.97685 18.2178C3.61648 19.3959 4.94495 20.1118 6.36635 20.0357L7.53081 19.9697C7.54175 19.9697 7.55815 19.9697 7.56908 19.9798L8.5422 20.579C8.82101 20.7466 9.11623 20.8786 9.42238 20.97L7.3668 25.5045C7.24106 25.7837 6.96225 25.9716 6.6397 25.997C6.31715 26.0224 6.00553 25.8853 5.83059 25.6314L4.07024 23.1281L1.00328 23.5495C0.691663 23.5901 0.380047 23.4733 0.183237 23.2448C-0.0135731 23.0163 -0.0518417 22.7015 0.0684311 22.4324H0.073898ZM13.6319 25.4994L11.5764 20.97C11.8825 20.8786 12.1777 20.7516 12.4565 20.579L13.4296 19.9798C13.4406 19.9747 13.4515 19.9697 13.4679 19.9697L14.6324 20.0357C16.0538 20.1118 17.3822 19.3959 18.0219 18.2178L18.5467 17.248C18.5522 17.2378 18.5576 17.2327 18.5686 17.2277L20.9303 22.4324C21.0506 22.7015 21.0068 23.0113 20.8155 23.2448C20.6241 23.4784 20.3071 23.5952 19.9954 23.5495L16.9285 23.1281L15.1681 25.6263C14.9932 25.8802 14.6816 26.0173 14.359 25.9919C14.0365 25.9665 13.7577 25.7736 13.6319 25.4994Z"
                  fill="white"
                  fill-opacity="0.95"
                />
              </svg>

              <div>
                <h1 className="text-[.8vw] font-[700] text-white">
                  {charge[selected]
                    ? charge[selected].name
                    : "Selecione uma patente"}
                </h1>
                <p className="text-[.7vw] text-[#FFFFFF59]">
                  {charge[selected]
                    ? charge[selected].desc
                    : "Clique para escolher a patente inicial"}
                </p>
              </div>
            </div>
            <svg
              width="16"
              height="9"
              viewBox="0 0 16 9"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              className={`transition-transform ${isOpen ? "rotate-180" : ""}`}
            >
              <path
                d="M7.29289 8.70711C7.68342 9.09763..."
                fill="white"
                fillOpacity="0.5"
              />
            </svg>
          </div>

          {isOpen && (
            <div className="mt-[.3vw] max-h-[10vw] overflow-y-auto rounded-[.5vw] border border-[#FFFFFF08] bg-section">
              {charge.length === 0 && (
                <div className="px-[1vw] py-[.5vw]">
                  <p className="text-[.7vw] text-[#FFFFFF59]">Nenhuma patente disponível</p>
                </div>
              )}
              {charge.map((r, i) => {
                return (
                  <div
                    key={i}
                    onClick={() => {
                      setSelected(i);
                      setIsOpen(false);
                    }}
                    className="cursor-pointer px-[1vw] py-[.5vw] hover:bg-[#FFFFFF0A]"
                  >
                    <h1 className="text-[.8vw] font-[700] text-white">
                      {r.name}
                    </h1>
                    <p className="text-[.7vw] text-[#FFFFFF59]">{r.desc}</p>
                  </div>
                );
              })}
            </div>
          )}

          <div className="mt-[.5vw] flex w-full items-center justify-between gap-[.5vw]">
            <button
              onClick={handleConfirm}
              className="font-700 bg-tag h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF26] text-[.8vw] text-white"
            >
              Confirmar
            </button>
            <button
              onClick={handleClose}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80]"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export function FireMemberModal({ memberData }: { memberData: any }) {
  const navigate = useNavigate();

  const handleClose = () => {
    navigate(-1);
  };

  const handleConfirm = () => {
    Post.create("removePlayer", { id: memberData.id })
      .then(() => {
        handleClose();
      })
      .catch((error) => {
        console.error("[FIRE MODAL] Erro ao demitir membro:", error);
      });
  };

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Demitir Membro
          </h1>
        </div>
        <div className="w-full p-[1vw]">
          <p className="text-[.8vw] text-[#FFFFFF73]">
            Deseja demitir <strong>{memberData?.name}</strong> (ID:{" "}
            {memberData?.id}) da corporação?
          </p>
          <p className="mt-[.5vw] text-[.7vw] text-[#FF6868]">
            Esta ação não pode ser desfeita.
          </p>
          <div className="mt-[.5vw] flex w-full items-center justify-between gap-[.5vw]">
            <button
              onClick={handleConfirm}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FF686826] bg-[#FF6868] text-[.8vw] text-white shadow-[0_0_15px_#FF686880]"
            >
              Confirmar Demissão
            </button>
            <button
              onClick={handleClose}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80]"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
