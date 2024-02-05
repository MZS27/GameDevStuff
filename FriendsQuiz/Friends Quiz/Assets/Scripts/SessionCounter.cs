using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SessionCounter : MonoBehaviour
{
    int count = 1;

    void Awake()
    {
        DontDestroyOnLoad(this.gameObject);
    }

    public int GetCount()
    {
        return count;
    }

    public void IncrementCount()
    {
        count++;
    }
}
