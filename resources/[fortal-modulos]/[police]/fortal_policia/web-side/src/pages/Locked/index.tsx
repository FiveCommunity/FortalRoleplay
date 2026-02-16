import { useDescription, useOptions, useSelectUsers } from "@/stores/useLocked";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { optionsMockup } from "@/mockUp";

export function Locked() {
  const [suspect, setSuspect] = useState(false);
  const [prisonType, setPrisonType] = useState<"normal" | "maxima">("normal");
  const { current: options, set: setOptions } = useOptions();
  const { current: selected, set: setSelected } = useSelectUsers();
  const { current: value, set: setValue } = useDescription();
  const navigate = useNavigate();
  const location = useLocation();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: { pathname: location.pathname, search: location.search } },
    });
  };

  useEffect(() => {
    Post.create("getOptions", {}, optionsMockup).then((resp: any) => {
      setOptions(resp);
    });
  }, []);

  function toggleSelection(type: keyof typeof selected, item: { id: number }) {
    const list = selected[type];

    // Verificar se list é um array
    if (!Array.isArray(list)) {
      return;
    }

    const alreadySelected = list.some((i: any) => i.id === item.id);

    const updateList = alreadySelected
      ? list.filter((i: any) => i.id !== item.id)
      : [...list, item];

    setSelected({
      ...selected,
      [type]: updateList,
    });
  }

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.locked className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Prender Suspeitos
        </h1>
      </Title>

      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <h1 className="text-[.8vw] text-[#FFFFFF4D]">
          Você está realizando uma apreensão.
        </h1>

        <div className="mt-[.5vw] flex h-[28.5vw] w-full flex-col gap-[.5vw] overflow-auto">
          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Adicionar Suspeitos</h1>
            </div>

            <div className="flex w-full p-[.5vw]">
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                <div
                  onClick={() => setSuspect(!suspect)}
                  className="flex h-[2.3vw] cursor-pointer items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.8vw]"
                >
                  <div className="flex items-center gap-[.5vw]">
                    <Icon.anex />
                    <h1 className="text-[.8vw] text-[#FFFFFF80]">
                      Anexar <span className="text-[#FFFFFFD9]">Suspeitos</span>
                    </h1>
                  </div>
                  <Icon.arrowBotom />
                </div>

                {suspect && (
                  <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                    {options.suspect.map((data) => {
                      const isSelected = selected.suspects.some(
                        (s) => s.id === data.id,
                      );
                      return (
                        <button
                          key={data.id}
                          onClick={() => toggleSelection("suspects", data)}
                          className="hover:bg-sucess relative flex h-[2.3vw] w-fit flex-none items-center gap-[.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.4vw] hover:border-[#79FF921A]"
                        >
                          {isSelected && (
                            <div className="absolute left-0 top-0 flex h-full w-full items-center justify-center rounded-[.3vw] bg-[#FF5858D9]">
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
                          )}
                          <div className="bg-tag flex h-[1.4vw] w-fit items-center rounded-[.2vw] border border-[#FFFFFF0D] px-[.5vw]">
                            <h1 className="text-[.8vw] font-[700] capitalize text-white">
                              #{data.id}
                            </h1>
                          </div>
                          <h1 className="text-[.8vw] font-[500] text-[#FFFFFFCC]">
                            {data.name}
                          </h1>
                        </button>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Infrações Cometidas</h1>
            </div>

            <div className="flex w-full p-[.5vw]">
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                <div
                  onClick={() => openModal("/panel/locked/infractions")}
                  className="group flex h-[2.3vw] cursor-pointer items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.8vw] hover:bg-white/2"
                >
                  <div className="flex items-center gap-[.5vw]">
                    <Icon.anex />
                    <h1 className="text-[.8vw] text-[#FFFFFF80]">
                      Anexar{" "}
                      <span className="text-[#FFFFFFD9] group-hover:text-white">
                        Infrações
                      </span>
                    </h1>
                  </div>
                </div>
                <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                  {selected.infractions.map((data, index) => {
                    return (
                      <button
                        key={index}
                        className={`bg-sucess relative flex h-[2.3vw] w-fit flex-none items-center gap-[.5vw] rounded-[.3vw] border border-[#79FF921A] px-[.4vw]`}
                      >
                        <div className="bg-tag flex h-[1.4vw] w-fit items-center rounded-[.2vw] border border-[#FFFFFF0D] px-[.5vw]">
                          <h1 className="text-[.8vw] font-[700] capitalize text-white">
                            Art. {data.art}
                          </h1>
                        </div>
                        <h1 
                          className="pr-[2vw] text-[.8vw] font-[500] text-[#FFFFFFCC] truncate"
                          title={data.description}
                        >
                          {data.description}
                        </h1>
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
                      </button>
                    );
                  })}
                </div>
              </div>
            </div>
          </div>

          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Tipo de Prisão</h1>
            </div>

            <div className="flex w-full p-[.5vw]">
              <div className="flex w-full items-center gap-[.5vw]">
                <button
                  onClick={() => setPrisonType("normal")}
                  className={`flex h-[2.5vw] w-full items-center justify-center rounded-[.3vw] border border-[#FFFFFF08] px-[.8vw] transition-all ${
                    prisonType === "normal"
                      ? "bg-tag border border-[#FFFFFF0D] text-white"
                      : "bg-section text-[#FFFFFF80] hover:text-white"
                  }`}
                >
                  <h1 className="text-[.8vw]">Prisão Normal</h1>
                </button>
                <button
                  onClick={() => setPrisonType("maxima")}
                  className={`flex h-[2.5vw] w-full items-center justify-center rounded-[.3vw] border border-[#FFFFFF08] px-[.8vw] transition-all ${
                    prisonType === "maxima"
                      ? "bg-tag border border-[#FFFFFF0D] text-white"
                      : "bg-section text-[#FFFFFF80] hover:text-white"
                  }`}
                >
                  <h1 className="text-[.8vw]">Segurança Máxima</h1>
                </button>
              </div>
            </div>
          </div>

          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Descrição da Apreensão</h1>
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
                    placeholder="Descreva a apreensão aqui..."
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
                setSelected({ suspects: [], infractions: [] });
                setValue("");
                setPrisonType("normal");
              }}
              className="h-[2.5vw] w-full rounded-[.5vw] border border-[#FFFFFF08] bg-section text-[#FFFFFFD9] hover:text-white"
            >
              Resetar Dados
            </button>
            <button
              onClick={() => {
                setSelected({
                  ...selected,
                  prisonType: prisonType,
                } as any);
                openModal("/panel/locked/modal");
              }}
              className="bg-tag h-[2.5vw] w-[8vw] rounded-[.4vw] border border-[#FFFFFF0D] text-[.8vw] text-white"
            >
              Prender
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
