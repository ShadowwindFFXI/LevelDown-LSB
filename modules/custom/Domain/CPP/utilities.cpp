/************************************************************************
* Loxley Quest System Utilities
*************************************************************************
* Copyright (c) 2025 LoxleyXI
*
* https://github.com/LoxleyXI/LQS
*************************************************************************
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see http://www.gnu.org/licenses/
************************************************************************/
#include "map/utils/moduleutils.h"
#include "common/timer.h"
#include "enums/chat_message_type.h"
#include "lua/luautils.h"
#include "map_engine.h"
#include "packets/s2c/0x017_chat_std.h"
#include "packets/s2c/0x029_battle_message.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"
#include "common/lua.h"
#include "map/utils/charutils.h"
#include "map/utils/itemutils.h"
#include "map/item_container.h"
#include "map/trade_container.h"

#include "map/lua/lua_baseentity.h"




class LqsUtilModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        /************************************************************************
        * Utilities
        *************************************************************************/
        lua["CBaseEntity"]["fmt"] = [this](CLuaBaseEntity* PLuaBaseEntity, std::string const& message, sol::variadic_args va) -> void
        {
            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            CCharEntity* PChar = (CCharEntity*)PEntity;
            PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_NS_SAY, lua_fmt(message, va).c_str(), "");
        };

        lua["CBaseEntity"]["sys"] = [this](CLuaBaseEntity* PLuaBaseEntity, std::string const& message, sol::variadic_args va) -> void
        {
            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            CCharEntity* PChar = (CCharEntity*)PEntity;
            PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, lua_fmt(message, va).c_str(), "");
        };

 

        /************************************************************************
        * Custom Events
        *************************************************************************/
        lua["CBaseEntity"]["ceFace"] = [](CLuaBaseEntity* PLuaBaseEntity, CLuaBaseEntity* player) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            CBaseEntity* PPlayer = player->GetBaseEntity();

            auto* const PChar       = dynamic_cast<CCharEntity*>(PPlayer);
            auto rot                = PEntity->loc.p.rotation;
            auto status             = PEntity->status;

            PEntity->loc.p.rotation = worldAngle(PEntity->loc.p, PChar->loc.p);
            PEntity->status = STATUS_TYPE::NORMAL;

            PChar->updateEntityPacket(PEntity, ENTITY_UPDATE, UPDATE_POS);

            PEntity->loc.p.rotation = rot;
            PEntity->status         = status;
        };

        lua["CBaseEntity"]["ceFaceNpc"] = [](CLuaBaseEntity* PLuaBaseEntity, CLuaBaseEntity* player, CLuaBaseEntity* npc) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            CBaseEntity* PPlayer = player->GetBaseEntity();
            CBaseEntity* PNpc    = npc->GetBaseEntity();

            auto* const PChar       = dynamic_cast<CCharEntity*>(PPlayer);
            auto        rot         = PEntity->loc.p.rotation;
            auto        status      = PEntity->status;

            PEntity->loc.p.rotation = worldAngle(PEntity->loc.p, PNpc->loc.p);
            PEntity->status         = STATUS_TYPE::NORMAL;

            PChar->updateEntityPacket(PEntity, ENTITY_UPDATE, UPDATE_POS);

            PEntity->loc.p.rotation = rot;
            PEntity->status         = status;
        };

        lua["CBaseEntity"]["ceTurn"] = [](CLuaBaseEntity* PLuaBaseEntity, CLuaBaseEntity* player, uint8 rot) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            CBaseEntity* PPlayer = player->GetBaseEntity();

            auto* const PChar   = dynamic_cast<CCharEntity*>(PPlayer);
            auto        current = PEntity->loc.p.rotation;
            auto        status  = PEntity->status;

            PEntity->loc.p.rotation = rot;
            PEntity->status         = STATUS_TYPE::NORMAL;

            PChar->updateEntityPacket(PEntity, ENTITY_UPDATE, UPDATE_POS);

            PEntity->loc.p.rotation = current;
            PEntity->status         = status;
        };

        lua["CBaseEntity"]["ceReset"] = [](CLuaBaseEntity* PLuaBaseEntity, CLuaBaseEntity* target) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            CBaseEntity* PTarget = target->GetBaseEntity();

            auto* const PChar = dynamic_cast<CCharEntity*>(PTarget);
            PChar->updateEntityPacket(PEntity, ENTITY_UPDATE, UPDATE_POS);
        };

        lua["CBaseEntity"]["ceSpawn"] = [](CLuaBaseEntity* PLuaBaseEntity, CLuaBaseEntity* target) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            CBaseEntity* PTarget = target->GetBaseEntity();

            auto* const PChar = dynamic_cast<CCharEntity*>(PTarget);
            auto        status = PEntity->status;
            PEntity->status = STATUS_TYPE::NORMAL;
            PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
            PEntity->status = status;
        };

        lua["CBaseEntity"]["ceDespawn"] = [](CLuaBaseEntity* PLuaBaseEntity, CLuaBaseEntity* target) -> void {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            CBaseEntity* PTarget = target->GetBaseEntity();

            auto* const PChar = dynamic_cast<CCharEntity*>(PTarget);
            auto        status = PEntity->status;
            PEntity->status    = STATUS_TYPE::DISAPPEAR;
            PChar->updateEntityPacket(PEntity, ENTITY_DESPAWN, UPDATE_DESPAWN);
            PEntity->status = status;
        };

        lua["CBaseEntity"]["setLookString"] = [](CLuaBaseEntity* PLuaBaseEntity, const std::string lookString) -> void {
            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            PEntity->look = stringToLook(lookString);

            // TODO: Add missing packet update
            // ------------------------------------------------
            // PEntity->updatemask |= UPDATE_LOOK;
            // PEntity->loc.zone->UpdateEntityPacket(PEntity, ENTITY_UPDATE, UPDATE_LOOK);
        };
    }
};

REGISTER_CPP_MODULE(LqsUtilModule);
