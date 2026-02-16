import {
  AddMember,
  FireMemberModal,
} from "@/components/_components/Modals/AddMember";
import { Navigate, Route, Routes, useLocation } from "react-router-dom";

import { AnnounceModal } from "@/components/_components/Modals/AnnounceModal";
import { Description } from "@/components/_components/Modals/Description";
import { Fine } from "@/pages/Fine";
import { FineInfractions } from "@/components/_components/Modals/FineInfractions";
import { FineModal } from "@/components/_components/Modals/FineModal";
import { Home } from "@/pages/Home";
import { Locked } from "@/pages/Locked";
import { LockedInfractions } from "@/components/_components/Modals/LockedInfractions";
import { Members } from "@/pages/Members";
import { Navigation } from "@/components/_components/Navigation";
import { Occurrence } from "@/pages/Occurrence";
import { OccurrenceModal } from "@/components/_components/Modals/OccurrenceModal";
import { PrisonModal } from "@/components/_components/Modals/PrisionModal";
import { Search } from "@/pages/Search";
import { UserInformation } from "@/components/_components/Modals/userInformation";
import { Wanted } from "@/pages/Wanted";
import { WantedUserModal } from "@/components/_components/Modals/WantedUserModal";
import { WantedVehicleModal } from "@/components/_components/Modals/WantedVehicleModal";
import { DeleteAnnounceModal } from "@/components/_components/Modals/DeleteAnnounceModal";
import { SuspectSearchModal } from "@/components/_components/Modals/SuspectSearchModal";
import { usePermissions } from "@/providers/Permissions";

// Componente para proteger rotas
const ProtectedRoute = ({
  children,
  pageName,
}: {
  children: React.ReactNode;
  pageName: string;
}) => {
  const { isLoading, canAccessPage } = usePermissions();

  if (isLoading) {
    return (
      <div className="flex h-full w-full items-center justify-center">
        <div className="text-white">Carregando...</div>
      </div>
    );
  }

  const hasAccess = canAccessPage(pageName);

  if (!hasAccess) {
    return <Navigate to="/panel" replace />;
  }

  return <>{children}</>;
};

export function Panel() {
  const location = useLocation();

  const state = location.state as { backgroundLocation?: Location };
  const backgroundLocation = state?.backgroundLocation ?? location;

  return (
    <div className="relative flex h-[35vw] w-[62vw] items-start rounded-[.8vw] border border-[#FFFFFF0D] bg-main">
      <Navigation />
      <Routes location={backgroundLocation}>
        <Route index element={<Home />} />
        <Route
          path="search"
          element={
            <ProtectedRoute pageName="search">
              <Search />
            </ProtectedRoute>
          }
        />
        <Route
          path="locked"
          element={
            <ProtectedRoute pageName="locked">
              <Locked />
            </ProtectedRoute>
          }
        />
        <Route
          path="fine"
          element={
            <ProtectedRoute pageName="fine">
              <Fine />
            </ProtectedRoute>
          }
        />
        <Route
          path="wanted"
          element={
            <ProtectedRoute pageName="wanted">
              <Wanted />
            </ProtectedRoute>
          }
        />
        <Route
          path="occurrence"
          element={
            <ProtectedRoute pageName="occurrence">
              <Occurrence />
            </ProtectedRoute>
          }
        />
        <Route
          path="members"
          element={
            <ProtectedRoute pageName="members">
              <Members />
            </ProtectedRoute>
          }
        />
      </Routes>

      <Routes>
        <Route path="modal" element={<AnnounceModal />} />
        <Route path="locked/modal" element={<PrisonModal />} />
        <Route path="locked/infractions" element={<LockedInfractions />} />
        <Route path="fine/modal" element={<FineModal />} />
        <Route path="fine/infractions" element={<FineInfractions />} />
        <Route path="wanted/modalvehicle" element={<WantedVehicleModal />} />
        <Route path="wanted/modaluser" element={<WantedUserModal />} />
        <Route path="occurrence/modal" element={<OccurrenceModal />} />
        <Route path="search/info" element={<Description />} />
        <Route path="members/modal" element={<AddMember />} />
        <Route path="members/informations" element={<UserInformation />} />
        <Route
          path="members/fire"
          element={<FireMemberModal memberData={location.state?.memberData} />}
        />
        <Route
          path="delete-announce"
          element={<DeleteAnnounceModal />}
        />
        <Route
          path="occurrence/suspect-search"
          element={<SuspectSearchModal />}
        />
      </Routes>
    </div>
  );
}
