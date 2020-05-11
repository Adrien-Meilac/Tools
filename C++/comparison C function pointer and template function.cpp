#include <iostream>
#include <ctime>
#include <chrono>

#define _USE_MATH_DEFINES
#include <math.h>

using namespace std;

template<typename F>
double bisection(F f, double lower, double upper, unsigned long step)
{
    unsigned long i = 0;
    double middle, f_middle;
    double f_lower = f(lower), f_upper = f(upper);
    while(i < step)
    {

        middle = (lower + upper) / 2;
        f_middle = f(middle);
        if(f_middle * f_lower > 0)
        {
            lower = middle;
            f_lower = f_middle;
        }
        else
        {
            upper = middle;
            f_upper = f_middle;
        }
        i++;
    }

    return middle;
}

extern "C" {
double bisection_C(double (*f)(double), double lower, double upper, unsigned long step)
{
    unsigned long i = 0;
    double middle, f_middle;
    double f_lower = (*f)(lower), f_upper = (*f)(upper);
    while(i < step)
    {

        middle = (lower + upper) / 2;
        f_middle = (*f)(middle);
        if(f_middle * f_lower > 0)
        {
            lower = middle;
            f_lower = f_middle;
        }
        else
        {
            upper = middle;
            f_upper = f_middle;
        }
        i++;
    }

    return middle;
}
}

template<typename F>
void random_call(F f, double lower, double upper, unsigned long step)
{
    double z;
    for(unsigned long i = 0; i < step; i++)
    {
        z = f((upper - lower) * rand() / RAND_MAX + lower);
    }
}

extern "C" {
void random_call_C(double (*f)(double), double lower, double upper, unsigned long step)
{
    double z;
    for(unsigned long i = 0; i < step; i++)
    {
        z = (*f)((upper - lower) * rand() / RAND_MAX + lower);
    }
}
}

double essai(double x)
{
    return cos(x);
}

int main()
{
    srand (time (NULL));
    std::chrono::time_point<std::chrono::high_resolution_clock> start, t1, t2;
    unsigned long N = 100000;
    start = std::chrono::high_resolution_clock::now();
    for(unsigned int i = 0; i < 10000; i++)
    {
        //bisection(essai, 2 * M_PI + 0.02 , 2 * M_PI + M_PI - 0.3, N);
        random_call(essai, - 1000, 1000, N);
    }
    t1 = std::chrono::high_resolution_clock::now();
    for(unsigned int i = 0; i < 10000; i++)
    {
        // bisection_C(essai, 2 * M_PI + 0.02 , 2 * M_PI + M_PI - 0.3, N);
        random_call_C(essai, - 1000, 1000, N);
    }
    t2 = std::chrono::high_resolution_clock::now();
    std::cout << "La methode de bisection via C++ donne en temps " << std::chrono::duration_cast<std::chrono::milliseconds>(t1 - start).count() << std::endl;
    std::cout << "La methode de bisection via C donne en temps " << std::chrono::duration_cast<std::chrono::milliseconds>(t2 - t1).count();
    return 0;
}
