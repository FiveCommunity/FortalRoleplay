import { useOptions, useSelectUsers } from "@/stores/useFine";

import { Icon } from "../../Navigation";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

export function FineInfractions() {
  const { current: options } = useOptions();
  const { current: selected, set: setSelected } = useSelectUsers();
  const [search, setSearch] = useState("");
  const navigate = useNavigate();

  function toggleSelection(type: keyof typeof selected, item: { id: number }) {
    const list = selected[type];
    const alreadySelected = list.some((i) => i.id === item.id);

    const updateList = alreadySelected
      ? list.filter((i) => i.id !== item.id)
      : [...list, item];

    setSelected({
      ...selected,
      [type]: updateList,
    });
  }

  return (
    <div className="bg-close absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center rounded-[.5vw]">
      <div className="w-[40vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="text-[.8vw] font-[700] text-white">
            Anexar Infrações
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <p className="text-[.8vw] font-[500] text-[#FFFFFF80]">
            Buscar Infrações
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
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M7.11678 1.99363e-08C5.98188 0.00010002 4.86338 0.2716 3.85478 0.7918C2.84608 1.3121 1.97638 2.066 1.31838 2.9907C0.66038 3.9154 0.23298 4.984 0.0719799 6.1074C-0.0890201 7.2308 0.0209807 8.3765 0.392781 9.4487C0.764581 10.521 1.38738 11.4888 2.20928 12.2715C3.03128 13.0541 4.02848 13.6288 5.11768 13.9476C6.20688 14.2665 7.35658 14.3203 8.47078 14.1045C9.58508 13.8887 10.6316 13.4096 11.523 12.7071L14.5809 15.765C14.7389 15.9175 14.9504 16.0019 15.1699 16C15.3895 15.9981 15.5995 15.91 15.7547 15.7548C15.91 15.5995 15.9981 15.3895 16 15.17C16.0019 14.9504 15.9175 14.7389 15.7649 14.581L12.707 11.5231C13.5343 10.4736 14.0494 9.2125 14.1933 7.8839C14.3373 6.5554 14.1043 5.2131 13.521 4.0108C12.9378 2.8085 12.0278 1.7947 10.8952 1.0854C9.76258 0.376 8.45318 -9.99801e-05 7.11678 1.99363e-08ZM1.67408 7.1172C1.67408 5.6737 2.24748 4.2894 3.26818 3.2687C4.28888 2.248 5.67328 1.6746 7.11678 1.6746C8.56028 1.6746 9.94468 2.248 10.9654 3.2687C11.9862 4.2894 12.5596 5.6737 12.5596 7.1172C12.5596 8.5606 11.9862 9.945 10.9654 10.9656C9.94468 11.9863 8.56028 12.5597 7.11678 12.5597C5.67328 12.5597 4.28888 11.9863 3.26818 10.9656C2.24748 9.945 1.67408 8.5606 1.67408 7.1172Z"
                fill="white"
                fill-opacity="0.5"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M7.11678 1.99363e-08C5.98188 0.00010002 4.86338 0.2716 3.85478 0.7918C2.84608 1.3121 1.97638 2.066 1.31838 2.9907C0.66038 3.9154 0.23298 4.984 0.0719799 6.1074C-0.0890201 7.2308 0.0209807 8.3765 0.392781 9.4487C0.764581 10.521 1.38738 11.4888 2.20928 12.2715C3.03128 13.0541 4.02848 13.6288 5.11768 13.9476C6.20688 14.2665 7.35658 14.3203 8.47078 14.1045C9.58508 13.8887 10.6316 13.4096 11.523 12.7071L14.5809 15.765C14.7389 15.9175 14.9504 16.0019 15.1699 16C15.3895 15.9981 15.5995 15.91 15.7547 15.7548C15.91 15.5995 15.9981 15.3895 16 15.17C16.0019 14.9504 15.9175 14.7389 15.7649 14.581L12.707 11.5231C13.5343 10.4736 14.0494 9.2125 14.1933 7.8839C14.3373 6.5554 14.1043 5.2131 13.521 4.0108C12.9378 2.8085 12.0278 1.7947 10.8952 1.0854C9.76258 0.376 8.45318 -9.99801e-05 7.11678 1.99363e-08ZM1.67408 7.1172C1.67408 5.6737 2.24748 4.2894 3.26818 3.2687C4.28888 2.248 5.67328 1.6746 7.11678 1.6746C8.56028 1.6746 9.94468 2.248 10.9654 3.2687C11.9862 4.2894 12.5596 5.6737 12.5596 7.1172C12.5596 8.5606 11.9862 9.945 10.9654 10.9656C9.94468 11.9863 8.56028 12.5597 7.11678 12.5597C5.67328 12.5597 4.28888 11.9863 3.26818 10.9656C2.24748 9.945 1.67408 8.5606 1.67408 7.1172Z"
                fill="url(#paint0_radial_1153_3)"
                fill-opacity="0.25"
              />
              <path
                d="M7.11718 0.5C8.35948 0.5 9.57698 0.849401 10.6299 1.5088C11.6829 2.1683 12.529 3.1116 13.0713 4.2295C13.6134 5.3472 13.8301 6.595 13.6963 7.8301C13.5624 9.0653 13.0836 10.2381 12.3145 11.2139L12.0391 11.5625L15.4053 14.9287L15.4463 14.9795C15.4818 15.0345 15.5006 15.0996 15.5 15.166C15.4991 15.2543 15.4638 15.3389 15.4014 15.4014C15.3389 15.4638 15.2543 15.4991 15.166 15.5C15.0996 15.5006 15.0345 15.4818 14.9795 15.4463L14.9287 15.4053L11.5625 12.0391L11.2139 12.3145C10.3852 12.9675 9.41178 13.4126 8.37598 13.6133C7.33998 13.8139 6.27048 13.7642 5.25778 13.4678C4.24518 13.1713 3.31778 12.6367 2.55368 11.9092C1.78968 11.1816 1.21088 10.2819 0.865178 9.2852C0.519578 8.2883 0.417678 7.2231 0.567378 6.1787C0.717078 5.1342 1.11378 4.14 1.72558 3.2803C2.33738 2.4206 3.14618 1.72 4.08398 1.2363C5.02178 0.7526 6.06198 0.5001 7.11718 0.5ZM7.11718 1.1748C5.54118 1.1748 4.02948 1.8007 2.91498 2.915C1.80058 4.0295 1.17378 5.5411 1.17378 7.1172C1.17378 8.6932 1.80058 10.2049 2.91498 11.3193C4.02948 12.4336 5.54118 13.0596 7.11718 13.0596C8.69318 13.0595 10.2049 12.4337 11.3193 11.3193C12.4338 10.2049 13.0596 8.6932 13.0596 7.1172C13.0596 5.5412 12.4337 4.0295 11.3193 2.915C10.2049 1.8007 8.69318 1.1749 7.11718 1.1748Z"
                stroke="white"
                stroke-opacity="0.05"
              />
              <defs>
                <radialGradient
                  id="paint0_radial_1153_3"
                  cx="0"
                  cy="0"
                  r="1"
                  gradientUnits="userSpaceOnUse"
                  gradientTransform="translate(7.97488 12.2667) scale(9.60502 15.2753)"
                >
                  <stop stop-color="white" />
                  <stop offset="1" stop-color="white" stop-opacity="0" />
                </radialGradient>
              </defs>
            </svg>
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="h-full w-[21.2vw] bg-transparent text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
              placeholder="Buscar por artigo"
            />
          </div>
          <div className="flex h-[14vw] w-full flex-wrap gap-[.3vw] overflow-auto">
            {options.infractions
              .filter(
                (data) =>
                  data.art
                    .toString()
                    .toLowerCase()
                    .includes(search.toLowerCase()) ||
                  data.description.toLowerCase().includes(search.toLowerCase()),
              )
              .map((data, index) => {
                const item = { ...data, id: index };
                const isSelected = selected.infractions.some(
                  (i) => i.id === index,
                );

                return (
                  <button
                    key={index}
                    onClick={() => toggleSelection("infractions", item)}
                    className={`hover:bg-sucess ${
                      isSelected && "bg-sucess border-[#79FF921A]"
                    } relative flex h-[2.2vw] w-[calc(50%-0.15vw)] flex-none items-center gap-[.2vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.2vw] hover:border-[#79FF921A]`}
                  >
                    <div className="bg-tag flex h-[1.3vw] w-fit items-center rounded-[.2vw] border border-[#FFFFFF0D] px-[.2vw] flex-shrink-0">
                      <h1 className="text-[.6vw] font-[700] capitalize text-white whitespace-nowrap">
                        Art. {data.art}
                      </h1>
                    </div>
                    <div className="flex flex-col flex-1 min-w-0 gap-[.1vw] overflow-hidden">
                      <h1 
                        className="text-[.6vw] font-[500] text-[#FFFFFFCC] truncate leading-tight"
                        title={data.description}
                      >
                        {data.description}
                      </h1>
                    </div>
                    {isSelected && (
                      <svg
                        width=".5vw"
                        height=".4vw"
                        className="absolute right-[.2vw] flex-shrink-0"
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
              })}
          </div>
          <div className="flex w-full items-center justify-between gap-[.5vw]">
            <button
              onClick={() => navigate("/panel/fine")}
              className="bg-tag h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF26] text-[.8vw] font-[700] text-white hover:scale-95"
            >
              Adicionar Infrações
            </button>
            <button
              onClick={() => navigate("/panel/fine")}
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
