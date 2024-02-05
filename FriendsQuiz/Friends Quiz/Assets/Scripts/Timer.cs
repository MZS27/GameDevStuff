using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Timer : MonoBehaviour
{
    [SerializeField] float timeToCompleteQuestion;
    [SerializeField] float timeToViewAnswer;
    
    float timerValue;
    public bool loadNextQuestion;

    public float fillFraction;
    public bool isAnsweringQuestion;

    void Update()
    {
        UpdateTimer();
    }
    

    public void CancelTimer()
    {
        timerValue = 0;
    }

    void UpdateTimer()
    {
        timerValue -= Time.deltaTime;

        if(timerValue > 0)
        {
            fillFraction = isAnsweringQuestion ? timerValue/timeToCompleteQuestion : timerValue/timeToViewAnswer;
        }
        else //(timerValue <= 0)
        {
            if(isAnsweringQuestion)
            {
                timerValue = timeToViewAnswer;
                isAnsweringQuestion = false;
            }
            else
            {
                timerValue = timeToCompleteQuestion;
                isAnsweringQuestion = true;
                loadNextQuestion = true;
            }
        }
    }
}
