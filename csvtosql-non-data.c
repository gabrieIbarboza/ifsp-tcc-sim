#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <locale.h>


#define MAX_COLUMNS 10000
#define MAX_ROW_LENGTH 1000000


char *trim(char *s) {
    char *ptr;
    if (!s)
        return NULL;
    if (!*s)
        return s;      
    for (ptr = s + strlen(s) - 1; (ptr >= s) && isspace(*ptr); --ptr);
    ptr[1] = '\0';
    return (s);
}

char *str_replace(char *str, const char *old, const char *new) {
	char *out, *r;
	const char *p, *q;
	size_t oldSize = strlen(old);
	size_t count, outSize, newSize = strlen(new);
	int equals = (oldSize == newSize);
	if (!equals) {
		for (count = 0, p = str; (q = strstr(p, old)) != NULL; p = q + oldSize){
			count++;
		}
		outSize = p - str + strlen(p) + count * (newSize - oldSize);
	} else {
		outSize = strlen(str);
	}
	if ((out = malloc(outSize + 1)) == NULL){
		return (NULL);
	}
	for (r = out, p = str; (q = strstr(p, old)) != NULL; p = q + oldSize) {
		count = q - p;
		if (count) {
			memcpy(r, p, count);
			r += count;
		}
		memcpy(r, new, newSize);
		r += newSize;
	}
	strcpy(r, p);
	return (out);
}

char* sanitizer(const char* value) {
	char prev_loc[100];	
	strcpy(prev_loc, setlocale(LC_ALL, NULL));	
	setlocale(LC_ALL, "UTF-8");
	int i, count = 0;
	for (i = 0; value[i]; i++) {
		if (!iscntrl(value[i])) {
			count++;
		}
	}
	char *outStr = (char*)malloc(count + 1);
	if (outStr == NULL) {
		return NULL;
	}
	int j = 0;
	for (i = 0; value[i]; i++) {
		if (!iscntrl(value[i])) {
			outStr[j++] = value[i];
		}
	}
	outStr[j] = '\0';
	setlocale(LC_ALL, prev_loc);
	return (outStr);
}

char* escape_string(char *str) {
	char escape_chars[5][2] = {"\n", "\t", "\"", "\'", "\\"};
	for (int i = 0; i < 5; i++) {
		str = str_replace(str,  escape_chars[i], "");
	}
	str = str_replace(str,  "NATURAL", "NATURAL0");
	return(sanitizer(trim(str)));
}

int main(int argc, char *argv[]) {
	if (argc < 2) {
		printf("Usage: %s filename\n", argv[0]);
		return (1);
	}
	char *filename = argv[1];
	FILE *fp = fopen(filename, "r");
	if (fp == NULL) {
		printf("Error opening file %s\n", filename);
		return (1);
	}
	char table_name[100];
	strcpy(table_name, filename);
	int len = strlen(table_name);
	if (len > 4 && strcmp(table_name + len - 4, ".csv") == 0) {
		table_name[len - 4] = '\0';
	}
	char row[MAX_ROW_LENGTH];
	char *column_names[MAX_COLUMNS];
	int num_columns = 0;
	if (fgets(row, MAX_ROW_LENGTH, fp) != NULL) {
		char *token = strtok(row, ";");
		while (token != NULL && num_columns < MAX_COLUMNS) {
			int len = strlen(token);
			if (len > 2 && token[0] == '"' && token[len - 1] == '"') {
				token[len - 1] = '\0';
				token++;
			}
			column_names[num_columns++] = strdup(token);
			token = strtok(NULL, ";");
		}
	}
	printf("CREATE TABLE %s (\n", table_name);
	for (int i = 0; i < num_columns; i++) {
		printf("\t%s TEXT",  escape_string(column_names[i]));
		printf( (i < num_columns - 1) ? ",\n" : "\n" );
	}
	printf(");\n");
	
	fclose(fp);
	return 0;
}
