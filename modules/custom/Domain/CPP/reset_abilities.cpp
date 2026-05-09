/************************************************************************
* Reset Abilities
* 
* Resets all abilities except 2-hour from player
 ************************************************************************/

#include "map/utils/moduleutils.h"
#include "map/lua/lua_baseentity.h"
#include "map/recast_container.h"

class ResetAbilitiesModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        lua["CBaseEntity"]["resetAbilities"] = [](CLuaBaseEntity* PLuaBaseEntity) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            auto* const PChar    = dynamic_cast<CCharEntity*>(PEntity);

            PChar->PRecastContainer->ResetAbilities();
        };
    }
};

REGISTER_CPP_MODULE(ResetAbilitiesModule);
