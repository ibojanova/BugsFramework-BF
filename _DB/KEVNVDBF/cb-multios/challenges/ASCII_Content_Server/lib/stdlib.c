/*

Author: Jason Williams <jdw@cromulence.com>

Copyright (c) 2014 Cromulence LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
#include "libcgc.h"
#include "cgc_stdlib.h"
#include "cgc_stdint.h"

int cgc_memcpy( void *dest, void *src, cgc_size_t n )
{
        cgc_size_t index = 0;

        while ( index < n ) {
                ((char*)dest)[index] = ((char*)src)[index];
                index++;
        }

        return index;
}

int cgc_islower( int c )
{
        if ( c >= 0x61 && c <= 0x7a )
                return 1;
        else
                return 0;
}

int cgc_isupper( int c )
{
        if ( c >= 0x41 && c <= 0x5a )
                return 1;
        else
                return 0;
}

int cgc_toupper( int c )
{
    if ( c >= 'a' && c <= 'z' )
        return ('A' + (c - 'a'));
    else
        return c;
}

int cgc_tolower( int c )
{
    if ( c >= 'A' && c <= 'Z' )
        return ('a' + (c - 'A'));
    else
        return c;
}

int cgc_isalpha( int c )
{
        return cgc_islower( c ) | cgc_isupper( c );
}

int cgc_isalnum( int c )
{
        return cgc_isalpha( c ) | cgc_isdigit( c );
}

int cgc_isspace( int c )
{
    if ( c == ' ' ||
         c == '\t' ||
         c == '\n' ||
         c == '\v' ||
         c == '\f' ||
         c == '\r' )
        return 1;
    else
        return 0;
}

int cgc_isdigit( int c )
{
    if ( c >= '0' && c <= '9' )
        return 1;
    else
        return 0;
}

int cgc_isnan( double val )
{
    return __builtin_isnan( val );
}

int cgc_isinf( double val )
{
    return __builtin_isinf( val );
}

double cgc_atof(const char* str)
{
    if ( str == NULL )
        return 0.0;

    double val = 0.0;
    double scale = 0.1;
    int sign = 1;
    int part;

    // Skip whitespace
    while ( cgc_isspace( str[0] ) )
        str++;

    part = 0; // First part (+/-/./number is acceptable)

    while( str[0] != '\0' )
    {
        if ( str[0] == '-' )
        {
            if ( part != 0 )
                return 0.0;

            sign = -1;
            part++;
        }
        else if ( str[0] == '+' )
        {
            if ( part != 0 )
                return 0.0;

            part++;
        }
        else if ( str[0] == '.' )
        {
            if ( part == 0 || part == 1 )
                part = 2;
            else
                return 0.0;
        }
        else if ( cgc_isdigit( *str ) )
        {
            if ( part == 0 || part == 1 )
            {
                // In integer part
                part = 1;
                val = (val * 10.0) + (*str - '0');
            }
            else if ( part == 2 )
            {
                val += ((*str - '0') * scale);
                scale /= 10.0;
            }
            else
            {
                // part invalid
                return 0.0;
            }
        }
        else
            break;

        str++;
    }

    return (sign * val);
}


int cgc_atoi(const char* str)
{
    if ( str == NULL )
        return 0;

    int integer_part = 0;
    int sign = 1;
    int part;
    int digit_count = 0;

    // Skip whitespace
    while ( cgc_isspace( str[0] ) )
        str++;

    part = 0; // First part (+/-/number is acceptable)

    while( str[0] != '\0' )
    {
        if ( str[0] == '-' )
        {
            if ( part != 0 )
                return 0;

            sign = -1;
            part++;
        }
        else if ( str[0] == '+' )
        {
            if ( part != 0 )
                return 0;

            part++;
        }
        else if ( cgc_isdigit( *str ) )
        {
            if ( part == 0 || part == 1 )
            {
                // In integer part
                part = 1;
                integer_part = (integer_part * 10) + (*str - '0');

                digit_count++;

                if ( digit_count == 10 )
                    break;
            }
            else
            {
                // part invalid
                return 0;
            }
        }
        else
            break;

        str++;
    }

    return (sign * integer_part);
}

char *cgc_strcpy( char *dest, char *src )
{
    cgc_size_t i;

    for ( i = 0; ; i++ )
    {
        if ( src[i] == '\0' )
            break;

        dest[i] = src[i];
    }
    dest[i] = '\0';

    return (dest);
}

char *cgc_strncpy( char *dest, const char *src, cgc_size_t n )
{
    cgc_size_t i;

    for ( i = 0; i < n && src[i] != '\0'; i++)
        dest[i] = src[i];
    for ( ; i < n; i++)
        dest[i] = '\0';

    return (dest);
}

void cgc_bzero( void *buff, cgc_size_t len )
{
    cgc_size_t index = 0;
    unsigned char *c = buff;

    if ( buff == NULL ) {
        goto end;
    }

    if ( len == 0 ) {
        goto end;
    }

    for ( index = 0; index < len; index++ ) {
        c[index] = 0x00;
    }

end:
    return;
}

void *cgc_memset(void *s, int c, cgc_size_t n)
{
    unsigned char *t = (unsigned char *)s;
    while (--n)
        t[n] = (unsigned char)c;
    t[n] = (unsigned char)c;
    return(s);
}

int cgc_strcmp( const char *s1, const char *s2 )
{
    while ( *s1 && (*s1 == *s2) )
    {
      s1++,s2++;
    }
    return (*(const unsigned char *)s1 - *(const unsigned char *)s2);
}

int cgc_stricmp( const char *s1, const char *s2 )
{
    while ( *s1 && (cgc_tolower(*s1) == cgc_tolower(*s2)) )
    {
        s1++, s2++;
    }

    return (*(const unsigned char *)s1 - *(const unsigned char *)s2);
}

int cgc_strncmp( const char *s1, const char *s2, int count )
{
    int num_checked = 0;
    if (count < 1) {
        return -1;
    }
    while ( num_checked < count - 1 && *s1 && (*s1 == *s2) )
    {
      s1++,s2++;num_checked++;
    }
    return (*(const unsigned char *)s1 - *(const unsigned char *)s2);
}


char *cgc_strncat ( char *dest, const char *src, cgc_size_t n )
{
    cgc_size_t dest_len = cgc_strlen(dest);
    cgc_size_t i;

    if (dest == NULL || src == NULL)
    {
      return(dest);
    }
    for (i = 0; i < n && src[i] != '\0'; i++)
    {
      dest[dest_len+i] = src[i];
    }
    dest[dest_len+i] = '\0';

    return(dest);
}

int cgc_flush_input(int fd) {
    cgc_fd_set read_fds;
    int err;
    int ready_fd;
    struct cgc_timeval tv;
    char buffer[1024];
    cgc_size_t rcv_cnt;

    while (1)  {

        cgc_bzero((char *)&read_fds, sizeof(read_fds));
        FD_SET(fd, &read_fds);

        tv.tv_sec = 0;
        tv.tv_usec = 10;

        err = cgc_fdwait(fd + 1, &read_fds, NULL, &tv, &ready_fd);
        if (err != 0) {
            return err;
        }

        if (!FD_ISSET(fd, &read_fds))
            break;
        else
            cgc_receive(fd, buffer, 1024, &rcv_cnt);

    }

    return 0;
} // flush_input()

cgc_size_t cgc_getline( char *buffer, cgc_size_t len)  {
    int count;

    count = cgc_receive_until(buffer, '\n', len);

    if (count==len)
        buffer[len-1]=0;
    else {
        buffer[count]=0;
    }

    return (count);

}

cgc_size_t cgc_receive_until( char *dst, char delim, cgc_size_t max )
{
    cgc_size_t len = 0;
    cgc_size_t rx = 0;
    char c = 0;

    while( len < max ) {
        dst[len] = 0x00;

        if ( cgc_receive( STDIN, &c, 1, &rx ) != 0 ) {
            len = 0;
            goto end;
        }

	if (rx == 0) {
		len = 0;
		goto end;
	}

        if ( c == delim ) {
            goto end;
        }

        dst[len] = c;
        len++;
    }
end:
    return len;
}
cgc_size_t cgc_receive_fixed(char *dest, cgc_size_t size) {
    cgc_size_t total_read = 0;
    int return_value;
    cgc_size_t bytes_received;
    while (total_read < size) {
        return_value = cgc_receive(STDIN, dest + total_read, size - total_read, &bytes_received);
      if (return_value != 0 || bytes_received == 0) {
        return -1;
      }
      total_read += bytes_received;
    }
    return total_read;
}

int cgc_receive_bytes (unsigned char *buffer, cgc_size_t size)
{
cgc_size_t count=0;
cgc_size_t remaining = 0;
cgc_size_t rxbytes=0;

    remaining = size - count;

    while(remaining)  {

        rxbytes = 0;

        if (cgc_receive(STDIN, buffer+count, remaining, &rxbytes) ==0 ) {

            remaining-=rxbytes;
            count+=rxbytes;
        }

        else {

            return(-1);
        }


    }

return 0;

}

cgc_size_t cgc_strcat( char *dest, char*src )
{
    cgc_size_t length = 0;
    cgc_size_t start = 0;

    if ( dest == NULL || src == NULL) {
        goto end;
    }

    start = cgc_strlen( dest );

    for ( ; src[length] != 0x00 ; start++, length++ ) {
        dest[start] = src[length];
    }

    length = start;
end:
    return length;
}

cgc_size_t cgc_strlen( char * str )
{
    cgc_size_t length = 0;

    if ( str == NULL ) {
        goto end;
    }

    while ( str[length] ) { length++; }

end:
    return length;
}

cgc_size_t cgc_itoa( char *out, cgc_size_t val, cgc_size_t max )
{
    cgc_size_t length = 0;
    cgc_size_t end = 0;
    cgc_size_t temp = 0;

    if ( out == NULL ) {
        goto end;
    }

    // Calculate the needed length
    temp = val;
    do {
        end++;
        temp /= 10;
    } while ( temp );

    // ensure we have enough room
    if ( end >= max ) {
        goto end;
    }

    length = end;

    // Subtract one to skip the null
    end--;

    do {
        out[end] = (val % 10) + 0x30;
        val /= 10;
        end--;
    } while ( val );

    out[length] = 0x00;
end:
    return length;
}

void cgc_puts( char *t )
{
    cgc_size_t size;
    cgc_size_t total_sent = 0;
    cgc_size_t len;

    if (!t) {
       return;
    }

    len = cgc_strlen(t);

    while (total_sent < len) {
        if (cgc_transmit(STDOUT, t+total_sent, len-total_sent, &size) != 0) {
            return;
        }
        total_sent += size;
    }
    size = 0;
    while (size != 1) {
        if (cgc_transmit(STDOUT, "\n", 1, &size) != 0) {
            return;
        }
    }
}

char *cgc_strchr(const char *s, int c) {
	while (*s != '\0') {
		if (*s == c) {
			return((char *)s);
		}
		s++;
	}
	if (*s == c) {
		return((char *)s);
	}
	return(NULL);
}

char *cgc_strrchr(const char *s, int c) {
    const char *r = s + cgc_strlen((char *)s);
    while (r != s) {
        if (*r == c) {
            return((char *)r);
        }
        r--;
    }
    if (*r == c) {
        return((char *)r);
    }
    return(NULL);
}

char *cgc_token = NULL;
char *cgc_prev_str = NULL;
unsigned int cgc_prev_str_len = 0;
char *cgc_prev_str_ptr = NULL;
char *cgc_strtok(char *str, const char *delim) {
	char *start;
	char *end;
	char *t;
	int i;

	// invalid input
	if (delim == NULL) {
		return(NULL);
	}
	
	// called on existing string
	if (str == NULL) {
		if (cgc_prev_str == NULL) {
			return(NULL);
		}
		// already parsed through end of original str
		if (cgc_prev_str_ptr >= cgc_prev_str+cgc_prev_str_len) {
			return(NULL);
		}
	} else {
		// called with new string, so free the old one
		if (cgc_prev_str) {
			cgc_deallocate(cgc_prev_str, cgc_prev_str_len);
			cgc_prev_str = NULL;
			cgc_prev_str_len = 0;
			cgc_prev_str_ptr = NULL;
		}
	}

	// not been called before, so make a copy of the string
	if (cgc_prev_str == NULL) {
		if (cgc_strlen(str) > 4096) {
			// too big
			return(NULL);
		} 
		cgc_prev_str_len = cgc_strlen(str);
		if (cgc_allocate(cgc_prev_str_len, 0, (void *)&cgc_prev_str)) {
			return(NULL);
		}
		cgc_strcpy(cgc_prev_str, str);
		cgc_prev_str_ptr = cgc_prev_str;
	}

	str = cgc_prev_str_ptr;

	// make sure the string isn't starting with a delimeter
	while (cgc_strchr(delim, str[0]) && str < cgc_prev_str+cgc_prev_str_len) {
		str++;
	}
	if (str >= cgc_prev_str+cgc_prev_str_len) {
		return(NULL);
	}

	// find the earliest next delimiter
	start = str;
	end = str+cgc_strlen(str);
	for (i = 0; i < cgc_strlen((char *)delim); i++) {
		if ((t = cgc_strchr(start, delim[i]))) {
			if (t != NULL && t < end) {
				end = t;
			}
		}
	}
	
	// populate the new token
	cgc_token = start;
	*end = '\0';

	cgc_prev_str_ptr = end+1;

	return(cgc_token);
}

cgc_ssize_t cgc_write( const void *buf, cgc_size_t count )
{
	cgc_size_t size;
	cgc_size_t total_sent = 0;

	if (!buf) {
		return(0);
	}

	while (total_sent < count) {
		if (cgc_transmit(STDOUT, buf+total_sent, count-total_sent, &size) != 0) {
			return(total_sent);
		}
		total_sent += size;
	}	

	return(total_sent);

}

char *cgc_strdup(char *s) 
{
        char *retval;

        if (!s) {
                return(NULL);
        }

        if (cgc_allocate(cgc_strlen(s)+1, 0, (void *)&retval)) {
                return(NULL);
        }

        cgc_bzero(retval, cgc_strlen(s)+1);
        cgc_strcpy(retval, s);

        return(retval);
}

