import "@/style/global.css";

import { Debugger } from "./utils/debugger";
import { HashRouter } from "react-router-dom";
import { Interface } from "@/components/Interface";
import { PermissionsProvider } from "@/providers/Permissions";
import ReactDOM from "react-dom/client";
import { VisibilityProvider } from "@/providers/Visibility";

declare global {
  interface Window {
    invokeNative?: any;
  }
}

new Debugger([
  {
    action: "setVisibility",
    data: "/panel",
  },
  {
    action: "setColor",
    data: "42, 82, 242",
  },
]);

const rootElement = document.getElementById("root");

if (rootElement) {
  try {
    const App = () => {
      return (
        <div
          style={{
            position: "fixed",
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            zIndex: 9999,
          }}
        >
          <HashRouter>
            <PermissionsProvider>
              <VisibilityProvider>
                <Interface />
              </VisibilityProvider>
            </PermissionsProvider>
          </HashRouter>
        </div>
      );
    };

    ReactDOM.createRoot(rootElement).render(<App />);
  } catch (error) {
    console.error("[NUI] Erro ao renderizar React:", error);
  }
} else {
  console.error("[NUI] Root element não encontrado!");
}
