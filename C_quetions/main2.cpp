#include<iostream>

int main(){
    
}

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool isNewPlayer = false;
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;  // Delete player if loading fails
            return;
        }
        isNewPlayer = true;
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (isNewPlayer) {
            delete player;  // Delete player if item creation fails
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (isNewPlayer) {
        delete player;  // Delete the player after saving if it was newly created
    }
}