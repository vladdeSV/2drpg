import entity_animal;
import enums;
import quest;

class EntityBison : EntityAnimal
{
    this(int x, int y)
    {
        super("Byser Michaels", x, y, '@', Color.yellow, new Quest
        (
            [
                "Small one, I have need of your help in gathering some food for me, please bring me some grass to eat.",
                "",
                "",
                "",
            ],
            this,
            [
                //QuestPart
                //(
                //    [
                //        "",
                //        "",
                //        ""
                //    ],
                //    {
                //        return
                //    },
                //    {

                //    }
                //),
                //QuestPart
                //(
                //    [
                //        "",
                //        "",
                //        ""
                //    ],
                //    {
                //        return
                //    },
                //    {

                //    }
                //),
                //QuestPart
                //(
                //    [
                //        "",
                //        "",
                //        ""
                //    ],
                //    {
                //        return
                //    },
                //    {

                //    }
                //),
            ],
        ));
    }
}

/+ Quest skelle
, new Quest
        (
            [
                "",
                "",
                "",
                "",
            ],
            this,
            [
                QuestPart
                (
                    [
                        "",
                        "",
                        ""
                    ],
                    {
                        return
                    },
                    {

                    }
                ),
            ],
        ));
+/
