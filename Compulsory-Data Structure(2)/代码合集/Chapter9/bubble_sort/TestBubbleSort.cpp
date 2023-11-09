#include "Assistance.h"			// 辅助软件包
#include "BubbleSort.h"		// 起泡排序算法

int main(void)
{
	int a[] = {55, 63, 38, 21, 63, 92, 16, 46, 87, 72};
	int n = 10;
	cout << "排序前:";
	Display(a, n);				// 显示a
	BubbleSort(a, n);			// 起泡排序
	cout << "排序后:";
	Display(a, n);				// 显示a

	system("PAUSE");			// 调用库函数system()
	return 0;					// 返回值0, 返回操作系统
}
