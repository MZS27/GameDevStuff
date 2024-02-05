using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScoreKeeper : MonoBehaviour
{
    int questionsSeen = 0;
    int correctAnswersCount = 0;

    public int GetCorrectAnswersCount()
    {
        return correctAnswersCount;
    }

    public void IncrementCorrectAnswersCount()
    {
        correctAnswersCount++;
    }

    public int GetQuestionsSeen()
    {
        return questionsSeen;
    }

    public void IncrementQuestionsSeen()
    {
        questionsSeen++;
    }

    public int CalculateScore()
    {
        if(correctAnswersCount==0) return 0;
        return Mathf.RoundToInt((float)correctAnswersCount / (float) questionsSeen * 100);
    }
}
