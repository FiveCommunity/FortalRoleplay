import { useNavigate } from "react-router-dom";
import { useDeleteAnnounce } from "@/stores/useDeleteAnnounce";

export function DeleteAnnounceModal() {
  const navigate = useNavigate();
  const { announceId, announceTitle, onConfirm, isDeleting, setIsDeleting, clearDeleteData } = useDeleteAnnounce();

  const handleConfirm = () => {
    if (onConfirm && announceId) {
      setIsDeleting(true);
      onConfirm(announceId);
      // O modal será fechado pelo componente pai após a confirmação
    }
  };

  const handleCancel = () => {
    clearDeleteData();
    navigate(-1);
  };

  return (
    <div className="bg-close absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.5vw]">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <div className="ml-[1vw] flex h-[2vw] w-[2vw] items-center justify-center rounded-full bg-red-500/20">
            <svg
              width="1.2vw"
              height="1.2vw"
              viewBox="0 0 24 24"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              className="text-red-400"
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
          </div>
          <h1 className="ml-[.5vw] text-[.8vw] font-[700] text-white">
            Deletar Anúncio
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <div className="flex flex-col gap-[.3vw]">
            <p className="text-[.8vw] text-[#FFFFFFBF]">
              Tem certeza que deseja deletar este anúncio?
            </p>
            <div className="rounded-[.3vw] border border-[#FFFFFF08] bg-[#FFFFFF05] p-[.5vw]">
              <p className="text-[.7vw] font-semibold text-white">
                {announceTitle}
              </p>
            </div>
            <p className="text-[.7vw] text-[#FFFFFF8C]">
              Esta ação não pode ser desfeita.
            </p>
          </div>
          <div className="flex w-full items-center justify-between">
            <button
              onClick={handleConfirm}
              disabled={isDeleting}
              className="h-[2.4vw] w-[12.2vw] rounded-[.4vw] border border-[#FF4444] bg-red-500 text-[.8vw] font-[700] text-white shadow-[0_0_15px_#FF444480] hover:scale-95 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isDeleting ? "Deletando..." : "Confirmar"}
            </button>
            <button
              onClick={handleCancel}
              disabled={isDeleting}
              className="h-[2.4vw] w-[12.2vw] rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80] disabled:opacity-50"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
