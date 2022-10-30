class Gonarch_Inventory extends Inventory;

var() Pawn PawnMaster;

Replication
{
    reliable if(Role == Role_Authority)
        PawnMaster;
}

function Destroyed()
{
    local Gonarch G;

    foreach DynamicActors(class'Gonarch',G)
    {
        if(G != None && PawnMaster == G)
        {
            G.ChildKilled();
        }
    }
}

defaultproperties
{
     ItemName="GonarchInv"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
}
