using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName="Question", fileName="newQuestion")]
public class QuestionScriptable : ScriptableObject
{
    [TextArea(2,10)]
    [SerializeField] string question = "Enter a new question here";
    [SerializeField] string [] options = new string[4];
    [SerializeField] int answerIndex;

    public string GetQuestion()
    {
        return question;
    }

    public int GetAnswerIndex()
    {
        return answerIndex;
    }

    public string getOptionText(int index)
    {
        return options[index];
    }
}
