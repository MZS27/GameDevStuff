using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    PlayScreen playScreen;
    Quiz quiz;
    EndScreen endScreen;
    SessionCounter sessionCounter;
    
    void Awake()
    {
        playScreen = FindObjectOfType<PlayScreen>();
        quiz = FindObjectOfType<Quiz>();
        endScreen = FindObjectOfType<EndScreen>();
        sessionCounter = FindObjectOfType<SessionCounter>();
    }

    void Start()
    {
        if(sessionCounter.GetCount() == 1)
        {
            playScreen.gameObject.SetActive(true);
            quiz.gameObject.SetActive(false);
        }
        else
        {
            OnPlay();
        }
        endScreen.gameObject.SetActive(false);
    } 

    void Update()
    {
        if(quiz.isQuizComplete)
        {
            quiz.gameObject.SetActive(false);
            endScreen.gameObject.SetActive(true);
            endScreen.ShowFinalScore();
        }
    }

    public void OnPlay()
    {
        playScreen.gameObject.SetActive(false);
        quiz.gameObject.SetActive(true);
    }

    public void OnReplayLevel()
    {
        sessionCounter.IncrementCount();
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        OnPlay();
    }
}
