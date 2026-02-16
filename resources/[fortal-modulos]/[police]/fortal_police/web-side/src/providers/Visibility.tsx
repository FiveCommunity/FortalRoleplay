import React, { createContext, useEffect, useState } from "react";

import { AnimationProvider } from "./Animation";
import { Post } from "@/hooks/post";
import { isEnvBrowser } from "@/utils/misc";
import { observe } from "@/hooks/observe";
import { useNavigate } from "react-router-dom";

export interface NuiVisibilityFrame {
  route: string | null;
  setRoute: (path: string | null) => void;
}

export const VisibilityContext = createContext<NuiVisibilityFrame | null>(null);

export const VisibilityProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const [route, setRoute] = useState<string | null>(null);
  const navigate = useNavigate();

  observe<string | null>("setVisibility", (data) => {
    if (!data) {
      setRoute(null);
    } else {
      setRoute(data);
    }
  });

  observe<string>("setColor", (data) => {
    document.documentElement.style.setProperty("--main-color", data);
  });

  observe("closeModal", () => {
    navigate(-1);
  });

  observe("clearSelections", () => {});

  useEffect(() => {
    const handleKeydown = (e: KeyboardEvent) => {
      if (route && ["Escape"].includes(e.code)) {
        setRoute(null);
      }
    };

    window.addEventListener("keydown", handleKeydown);
    return () => window.removeEventListener("keydown", handleKeydown);
  }, [route]);

  useEffect(() => {
    if (!route && !isEnvBrowser()) {
      Post.create("removeFocus");
    }
  }, [route]);

  return (
    <VisibilityContext.Provider
      value={{
        route,
        setRoute,
      }}
    >
      <AnimationProvider show={!!route}>{children}</AnimationProvider>
    </VisibilityContext.Provider>
  );
};
